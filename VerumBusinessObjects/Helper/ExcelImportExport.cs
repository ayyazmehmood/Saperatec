using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;
using System.Data;
using System.ComponentModel;
using VerumBusinessObjects.Helper;
using System.Reflection;
using System.Security.RightsManagement;
using DocumentFormat.OpenXml.Office2013.Word;

namespace VerumBusinessObjects
{
    public class ExcelImportExport
    {
        public static void ExportExcel<T>(List<T> data, string fileName, string dtName)
        {
            // Replace this with your desired Excel file path
            //string filePath = @"D:\Verum Project\Project\Verum\VerumAPI\ExportFiles\"+ fileName + ".xlsx";
            string filePath = LibrarySettings.ExportFilePath.Replace("[FileName]", fileName);

            var modelData = data.ToDataTable<T>(dtName);

            // Create the Excel file and insert data
            try
            {
                using (OleDbConnection connection = new OleDbConnection())
                {
                    // Set the connection string for Excel
                    connection.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties='Excel 12.0 Xml;HDR=YES;'";

                    connection.Open();

                    // Create the command to insert data
                    OleDbCommand command = new OleDbCommand();
                    command.Connection = connection;
                    command.CommandText = GetCreateTableQuery<T>(dtName);
                    // Execute the command to create the table
                    command.ExecuteNonQuery();

                    // Insert the data into the Excel file
                    using (OleDbDataAdapter adapter = new OleDbDataAdapter("SELECT * FROM ["+ dtName + "]", connection))
                    {
                        using (new OleDbCommandBuilder(adapter))
                        {
                            // get all columns
                            var col = GetColumnNames(modelData);
                            var guidlist = new List<string>();
                            foreach(var item in col)
                            {
                                var type = GetGuidColumnType(modelData, item);
                                if(type != null)
                                    guidlist.Add(item);
                            }

                            // convert guid to string
                            foreach(var item in guidlist)
                                modelData = ConvertGuidToStringDataTable(modelData, item);

                            adapter.Update(modelData);
                        }
                    }

                    connection.Close();
                }

                Console.WriteLine("Data inserted into Excel successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        // for sample 
        public static DataTable GetSampleDataTable()
        {
            //Sample data to be inserted into the Excel file
            DataTable modelData = new DataTable("ModelData");
            modelData.Columns.Add("ID", typeof(int));
            modelData.Columns.Add("Name", typeof(string));
            modelData.Columns.Add("Price", typeof(double));

            // Sample data rows
            modelData.Rows.Add(1, "Product A", 10.99);
            modelData.Rows.Add(2, "Product B", 15.49);
            modelData.Rows.Add(3, "Product C", 25.99);

            return modelData;
        }

        static void CreateTableFromModel<T>(string tableName, string filePath)
        {
            using (OleDbConnection connection = new OleDbConnection())
            {
                connection.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties='Excel 12.0 Xml;HDR=YES;'";
                connection.Open();

                string createTableQuery = GetCreateTableQuery<T>(tableName);

                using (OleDbCommand command = new OleDbCommand(createTableQuery, connection))
                {
                    command.ExecuteNonQuery();
                }
            }
        }

        static string GetCreateTableQuery<T>(string tableName)
        {
            PropertyInfo[] properties = typeof(T).GetProperties();
            string query = $"CREATE TABLE {tableName} (";

            for (int i = 0; i < properties.Length; i++)
            {
                if (properties[i].Name == "tBookTransaction")
                    continue;

                PropertyInfo property = properties[i];
                string columnName = property.Name;
                string columnType = GetSqlType(property.PropertyType);
                
                query += $"{columnName} {columnType}";

                if (i < properties.Length - 1)
                {
                    query += ",";
                }
            }

            query += ")";

            return query;
        }

        static string GetSqlType(Type type)
        {
            if (type == typeof(string))
                return "VARCHAR(255)";
            else if (type == typeof(int) || type == typeof(Int64) || type == typeof(Int32) || type == typeof(Nullable<int>) || type == typeof(Nullable<Int64>) || type == typeof(Nullable<Int32>))
                return "INT";
            else if(type == typeof(DateTime))
                return "datetime2";
            else
                return "VARCHAR(255)";
        }

        static string[] GetColumnNames(DataTable dataTable)
        {
            string[] columnNames = new string[dataTable.Columns.Count];
            for (int i = 0; i < dataTable.Columns.Count; i++)
            {
                columnNames[i] = dataTable.Columns[i].ColumnName;
            }
            return columnNames;
        }

        static Type GetGuidColumnType(DataTable dataTable, string columnName)
        {
            if (dataTable.Columns.Contains(columnName))
            {
                if(dataTable.Columns[columnName].DataType == typeof(Guid))
                {
                    return dataTable.Columns[columnName].DataType;
                }
            }

            return null;
        }

        static DataTable UpdateGuidToString(DataTable dataTable)
        {
            DataTable dataTable1 = dataTable;
            foreach (DataRow row in dataTable1.Rows)
            {
                foreach (DataColumn column in dataTable1.Columns)
                {
                    if (column.DataType == typeof(Guid))
                    {
                        object guidValue = row[column];
                        if (guidValue != DBNull.Value)
                        {
                            row[column] = guidValue.ToString();
                        }
                    }
                }
            }

            return dataTable1;
        }

        static DataTable ConvertGuidToStringDataTable(DataTable dataTable, string columnName)
        {
            DataTable newDataTable = new DataTable();

            foreach (DataColumn oldColumn in dataTable.Columns)
            {
                // Create new columns for the new DataTable with the same names and data types
                if(oldColumn.DataType == typeof(Guid))
                {
                    newDataTable.Columns.Add(oldColumn.ColumnName, typeof(string));
                }
                else
                {
                    newDataTable.Columns.Add(oldColumn.ColumnName, oldColumn.DataType);
                }
            }

            foreach (DataRow oldRow in dataTable.Rows)
            {
                DataRow newRow = newDataTable.NewRow();

                foreach (DataColumn oldColumn in dataTable.Columns)
                {
                    try
                    {
                        // Convert the GUID column to string and copy the data to the new DataTable
                        if (oldColumn.ColumnName == columnName && oldColumn.DataType == typeof(Guid))
                        {
                            var da = oldRow[oldColumn.ColumnName].ToString();
                            if(string.IsNullOrEmpty(da))
                                newRow[oldColumn.ColumnName] = DBNull.Value;
                            else
                                newRow[oldColumn.ColumnName] = da;
                        }
                        else
                        {
                            newRow[oldColumn.ColumnName] = oldRow[oldColumn];
                        }
                    }
                    catch(Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                    }
                }

                newDataTable.Rows.Add(newRow);
            }

            return newDataTable;
        }
    }
}
