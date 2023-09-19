using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;
using System.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Reflection;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Globalization;
using System.CodeDom;

namespace VerumBusinessObjects.Framework
{
    /// <summary>
    /// Provides utility methods from BusinessObject framework. Class cannot be instantiated.
    /// </summary>
    [ComVisible(false)]
    public static class BOUtilities
    {
        /// <summary>
        /// Calculates an index based on the number of years and months in a DateTime value. The difference between two YearMonthIndices equals the
        /// number of months between two date values.
        /// </summary>
        /// <param name="dateTime">Date value for which index is calculated</param>
        /// <returns>Number of months start with 1 for Jan 0000.</returns>
        static public int YearMonthIndex(DateTime dateTime)
        {
            return (dateTime.Year * 12 + dateTime.Month);
        }

        /// <summary>
        /// Function checks whether a combination of day, month and year is a valid date
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="day"></param>
        /// <returns>true if date is valid</returns>
        static public bool IsValidDate(int year, int month, int day)
        {
            if (month < 1 || month > 12)
                return false;

            if (year < 1900)
                return false;

            if (day < 1 || day > DateTime.DaysInMonth(year, month))
                return false;

            return true;
        }

        static public DateTime FirstOfYear(DateTime date)
        {
            return new DateTime(date.Year, 1, 1);
        }

        static public void TraceErrors(Exception ex, string ErrorContext = "")
        {
#if DEBUG
            Trace.WriteLine($"Exception caught in {new StackTrace().GetFrame(1).GetMethod().Name}");
            Trace.WriteLine($"Additional context: {ErrorContext}");
            Trace.WriteLine("Exception details:");
            Trace.WriteLine(ex.ToString());
#endif
        }

    }
}
