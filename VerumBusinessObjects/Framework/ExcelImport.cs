using DocumentFormat.OpenXml.Office2010.ExcelAc;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text.RegularExpressions;

namespace VerumBusinessObjects.Framework
{
    public class ExcelImport
    {
        public bool WorkbookOpen(string filename)
        {
            try
            {

                _Document = SpreadsheetDocument.Open(filename, false);
                _WorkbookPart = _Document.WorkbookPart;
                _StringTablePart = _WorkbookPart.SharedStringTablePart;
                _UserDataPart = _WorkbookPart.WorkbookUserDataPart;


                //_Workbook = _WorkbookPart.Workbook;
                //_Worksheet = null;

                return true;
            }
            catch 
            {
                return false;
            }

        }

        public int WorksheetCount
        {
            get
            {
                if (_WorkbookPart == null) return 0;
                else return _WorkbookPart.WorksheetParts.Count();
            }
        }

        //public bool WorksheetSelect( string worksheetName)
        //{
        //    try
        //    {
        //        if (_Workbook == null) return false;
        //        else
        //        {
        //            Sheet _Worksheet = _WorkbookPart.Workbook.Descendants<Sheet>().Where(s => s.Name == worksheetName).SingleOrDefault<Sheet>();
        //            _WorksheetPart = (WorksheetPart)_WorkbookPart.GetPartById(_Worksheet.Id);

        //            return true;
        //        }
        //    }
        //    catch
        //    {
        //        return false;
        //    }
        //}

        public bool WorksheetSelect(int index)
        {
            try
            {
                if (_WorkbookPart == null || index > WorksheetCount || index < 1) return false;
                else
                {
                    _WorksheetPart = _WorkbookPart.WorksheetParts.ElementAt(index - 1);
                    _Worksheet = _WorksheetPart.Worksheet;

                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

        public bool WorksheetSelectFirst()
        {
            return WorksheetSelect(1);
        }

        public bool WorksheetSelectNext()
        {
            try
            {
                if (_Worksheet == null) return false;
                {
                    Worksheet sheet = _Worksheet.NextSibling<Worksheet>();

                    if (sheet == null) return false;
                    else
                    {
                        _Worksheet = sheet;
                        return true;
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        public bool WorksheetSelectLast()
        {
            return WorksheetSelect(WorksheetCount);
        }

        public int RowCount
        {
            get
            {
                if (_Worksheet == null) return 0;
                else
                    return _Worksheet.Descendants<Row>().Count();
            }
        }

        public List<string> RowToList( int rowIndex)
        {
            var list = new List<string>(); ;

            try 
            {
                if (_Worksheet == null) return null;
                Row row = _Worksheet.Descendants<Row>().Where(r => r.RowIndex == rowIndex).First();

                if (row == null) return null;
                else if (row.ChildElements.Count == 0) return null;

                foreach (Cell c in row.ChildElements)
                {
                    string value = _CellString(c);
                    list.Add(value);
                }

                return list;
            }
            catch
            {
                return null;
            }
        }

        public DataTable GetDataTable( int rowStartIndex = 1)
        {
            DataTable dt = new DataTable();

            try
            {
                if (_Worksheet == null) return null;
                if (rowStartIndex >= RowCount) return null;

                // read table header
                var header = _Worksheet.Descendants<Row>().Where(r => r.RowIndex == rowStartIndex).FirstOrDefault();

                if (header != null)
                {
                    foreach (Cell c in header.ChildElements)
                    {
                        string value = _CellString(c);
                        dt.Columns.Add(value);
                    }
                }

                for (int i = rowStartIndex + 1; i <= RowCount; i++)
                {
                    DataRow dr = dt.NewRow();
                    Row row = _Worksheet.Descendants<Row>().Where(r => i == r.RowIndex).FirstOrDefault();
                    int j = 0;

                    if (row != null)
                    {
                        foreach (Cell c in row.Descendants<Cell>())
                        {
                            int? colIndex = _GetColumnIndex(((DocumentFormat.OpenXml.Spreadsheet.CellType)(c)).CellReference);

                            if (colIndex > j)
                            {
                                dr[j] = "";
                                j++;
                            }
                            //Get cell value
                            string value = _CellString(c);
                            dr[j] = value;
                            j++;
                            if (j == dt.Columns.Count)
                                break;
                        }

                        dt.Rows.Add(dr);
                    }
                }

                return dt;
            }
            catch
            {
                return null;
            }
        }

        static public T GetEntityFromXLS<T>(DataRow row) where T : new()
        {
            T entity = new T();
            string fromName;
            Type fromType;
            string toName;
            Type toType;
            PropertyInfo toProperty;
            bool flag_nullable = false;

            for (var i = 0; i < row.Table.Columns.Count; i++)
            {
                try
                {
                    fromName = row.Table.Columns[i].ColumnName;

                    if (row[fromName].GetType() != typeof(DBNull))
                    {
                        fromType = row.Table.Columns[i].DataType;
                        toName = fromName.Replace(" ", "_");
                        toName = toName.Replace("%", "Percent");
                        toName = toName.Replace("-", "_");
                        toName = toName.Replace("/", "_");
                        toProperty = typeof(T).GetProperty(toName);

                        if (toProperty != null)
                        {
                            toType = toProperty.PropertyType;

                            if (toType.Name == "Nullable`1")
                            {
                                flag_nullable = true;
                                toType = toType.GenericTypeArguments[0].UnderlyingSystemType;
                            }

                            if (fromType == typeof(string))
                            {
                                if (toType == typeof(string))
                                    //if (toType.Name == "Nullable`1")
                                    //    toProperty.SetValue(entity, Convert.ChangeType(row[fromName].ToString(), toType.GenericTypeArguments[0].UnderlyingSystemType));
                                    //else
                                    toProperty.SetValue(entity, row[fromName].ToString());

                                else if (toType == typeof(double))
                                {
                                    var s = row[fromName].ToString();
                                    double d = 0;

                                    if (s != "")
                                    {
                                        if (CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator == ".")
                                            s = s.Replace(",", ".");
                                        else if (CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator == ",")
                                            s = s.Replace(".", ",");

                                        d = Convert.ToDouble(s);
                                    }

                                    toProperty.SetValue(entity, d);
                                }

                                else if (toType == typeof(short))
                                    if (row[fromName].ToString() == "")
                                        toProperty.SetValue(entity, (short)0);
                                    else
                                        toProperty.SetValue(entity, Convert.ToInt16(row[fromName].ToString()));

                                else if (toType == typeof(int))
                                    if (row[fromName].ToString() == "")
                                        toProperty.SetValue(entity, (int)0);
                                    else
                                        toProperty.SetValue(entity, Convert.ToInt32(row[fromName].ToString()));

                                else if (toType == typeof(Guid))
                                    toProperty.SetValue(entity, Guid.Parse(row[fromName].ToString()));

                                else if (toType == typeof(DateTime))
                                {
                                    if (DateTime.TryParse(row[fromName].ToString(), out var d))
                                        toProperty.SetValue(entity, d.Date);
                                    else
                                        toProperty.SetValue(entity, DateTime.MinValue);
                                }

                                else if (toType == typeof(char))
                                {
                                    char[] c = row[fromName].ToString().ToCharArray();

                                    if (c.Length > 0)
                                        toProperty.SetValue(entity, c[0]);
                                }

                                else
                                    throw new BOException("Unsupported target data data type.", BOResult.ExcelImportUnknownDatatype);
                            }

                            else if (fromType == typeof(double))
                            {
                                if (toType == typeof(double))
                                    toProperty.SetValue(entity, Convert.ToDouble(row[fromName]));

                                else if (toType == typeof(short))
                                    toProperty.SetValue(entity, Convert.ToInt16(row[fromName]));

                                else if (toType == typeof(int))
                                    toProperty.SetValue(entity, Convert.ToInt32(row[fromName]));

                                else if (toType == typeof(string))
                                    toProperty.SetValue(entity, row[fromName].ToString());

                                else
                                    throw new BOException("Unsupported target data data type.", BOResult.ExcelImportUnknownDatatype);

                            }

                            else if (fromType == typeof(bool))
                            {
                                if (toType == typeof(bool))
                                    toProperty.SetValue(entity, row[fromName]);

                                else if (toType == typeof(double))
                                    toProperty.SetValue(entity, Convert.ToDouble(row[fromName]));

                                else if (toType == typeof(short))
                                    toProperty.SetValue(entity, Convert.ToInt16(row[fromName]));

                                else if (toType == typeof(int))
                                    toProperty.SetValue(entity, Convert.ToInt32(row[fromName]));

                                else if (toType == typeof(string))
                                    toProperty.SetValue(entity, row[fromName].ToString());

                                else
                                    throw new BOException("Unknown Excel import data type.", BOResult.ExcelImportUnknownDatatype);
                            }

                            else if (fromType == typeof(DateTime))
                            {
                                if (toType == typeof(DateTime))
                                    toProperty.SetValue(entity, row[fromName]);
                                else if (toType == typeof(string))
                                    toProperty.SetValue(entity, row[fromName].ToString());
                            }
#if (DEBUG)
                            else Console.WriteLine($"unknown property {toName}.");
#endif
                        }
                    }
                }
                catch (Exception ex)
                {
#if (DEBUG)
                    Console.WriteLine(ex.ToString());
#endif
                }
            }

            return entity;
        }

        public string GetCellValue( int rowIndex, int columnIndex)
        {
            try
            {
                if (_Worksheet == null || _Worksheet.Descendants<Row>().Count() < rowIndex) return null;
                Row row = _Worksheet.Descendants<Row>().ElementAt(rowIndex - 1);

                if (row == null) return null;
                else if (row.Descendants<Cell>().Count() < columnIndex) return null;
                else
                {
                    Cell cell = (Cell)row.Descendants<Cell>().ElementAt(columnIndex - 1);
                    return _CellString(cell);
                }
            }
            catch
            {
                return null;
            }
        }

        public static string GetCellValue2(string fileName,
        string sheetName,
        string addressName)
        {
            string value = null;

            // Open the spreadsheet document for read-only access.
            using (SpreadsheetDocument document =
                SpreadsheetDocument.Open(fileName, false))
            {
                // Retrieve a reference to the workbook part.
                WorkbookPart wbPart = document.WorkbookPart;

                // Find the sheet with the supplied name, and then use that 
                // Sheet object to retrieve a reference to the first worksheet.
                Sheet theSheet = wbPart.Workbook.Descendants<Sheet>().
                  Where(s => s.Name == sheetName).FirstOrDefault();

                // Throw an exception if there is no sheet.
                if (theSheet == null)
                {
                    throw new ArgumentException("sheetName");
                }

                // Retrieve a reference to the worksheet part.
                WorksheetPart wsPart =
                    (WorksheetPart)(wbPart.GetPartById(theSheet.Id));

                // Use its Worksheet property to get a reference to the cell 
                // whose address matches the address you supplied.
                Cell theCell = wsPart.Worksheet.Descendants<Cell>().
                  Where(c => c.CellReference == addressName).FirstOrDefault();

                // If the cell does not exist, return an empty string.
                if (theCell.InnerText.Length > 0)
                {
                    value = theCell.InnerText;

                    // If the cell represents an integer number, you are done. 
                    // For dates, this code returns the serialized value that 
                    // represents the date. The code handles strings and 
                    // Booleans individually. For shared strings, the code 
                    // looks up the corresponding value in the shared string 
                    // table. For Booleans, the code converts the value into 
                    // the words TRUE or FALSE.
                    if (theCell.DataType != null)
                    {
                        switch (theCell.DataType.Value)
                        {
                            case CellValues.SharedString:

                                // For shared strings, look up the value in the
                                // shared strings table.
                                var stringTable =
                                    wbPart.GetPartsOfType<SharedStringTablePart>()
                                    .FirstOrDefault();

                                // If the shared string table is missing, something 
                                // is wrong. Return the index that is in
                                // the cell. Otherwise, look up the correct text in 
                                // the table.
                                if (stringTable != null)
                                {
                                    value =
                                        stringTable.SharedStringTable
                                        .ElementAt(int.Parse(value)).InnerText;
                                }
                                break;

                            case CellValues.Boolean:
                                switch (value)
                                {
                                    case "0":
                                        value = "FALSE";
                                        break;
                                    default:
                                        value = "TRUE";
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            return value;
        }

        // PRIVATE FIELDS

        SpreadsheetDocument _Document = null;
        Workbook _Workbook = null;
        Worksheet _Worksheet = null;
        WorkbookPart _WorkbookPart = null;
        WorksheetPart _WorksheetPart = null;
        SharedStringTablePart _StringTablePart;
        WorkbookUserDataPart _UserDataPart;
        SheetData _SheetData = null;

        // PRIVATE METHODS

        string _CellString( Cell cell)
        {
            if (cell.ChildElements.Count == 0) return null;

            //get cell value
            string value = cell.ElementAt(0).InnerText;

            //Look up real value from shared string table
            if ((cell.DataType != null) && (cell.DataType == CellValues.SharedString))
                value = _StringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText;

            return value;
        }

        private int? _GetColumnIndex(string cellReference)
        {
            if (string.IsNullOrEmpty(cellReference)) return null;

            //remove digits
            string columnReference = Regex.Replace(cellReference.ToUpper(), @"[\d]", string.Empty);

            int columnNumber = -1;
            int mulitplier = 1;

            //working from the end of the letters take the ASCII code less 64 (so A = 1, B =2...etc)
            //then multiply that number by our multiplier (which starts at 1)
            //multiply our multiplier by 26 as there are 26 letters
            foreach (char c in columnReference.ToCharArray().Reverse())
            {
                columnNumber += mulitplier * ((int)c - 64);
                mulitplier = mulitplier * 26;
            }

            //the result is zero based so return columnnumber + 1 for a 1 based answer
            //this will match Excel's COLUMN function
            return columnNumber;
        }
    }
}
