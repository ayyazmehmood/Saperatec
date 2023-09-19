using System;
using System.ComponentModel;
using System.Windows;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Media;
using VerumBusinessObjects;

namespace VerumDesk.GUI
{
	public class BoolInvert : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((bool)value)
			{
				case true:
					return false;
				case false:
					return true;
			}
			return false;
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((bool)value)
			{
				case true:
					return false;
				case false:
					return true;
			}
			return false;
		}
	}

	public class TypePlanElementConverter : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((TypePlanElementEnum)value)
			{
				case TypePlanElementEnum.BookingRule:
					return "Buchungsreihe";
				case TypePlanElementEnum.Loan:
					return "Darlehen";
				case TypePlanElementEnum.Personnel:
					return "Personal";
				case TypePlanElementEnum.Purchase:
					return "Einkauf";
				case TypePlanElementEnum.Sale:
					return "Verkauf";
			}
			return "";
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			if (value is string)
			{
				switch ((string)value)
				{
					case "Buchungsreihe":
						return TypePlanElementEnum.BookingRule;
					case "Darlehen":
						return TypePlanElementEnum.Loan;
					case "Personal":
						return TypePlanElementEnum.Personnel;
					case "Einkauf":
						return TypePlanElementEnum.Purchase;
					case "Verkauf":
						return TypePlanElementEnum.Sale;
				}
			}
			return null;
		}
	}

	public class TypePlanStatusConverter : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((TypePlanStatusEnum)value)
			{
				case TypePlanStatusEnum.New:
					return "Neu";
				case TypePlanStatusEnum.Plan:
					return "Plan";
				case TypePlanStatusEnum.Baseline:
					return "Budget";
				case TypePlanStatusEnum.Forecast:
					return "Forecast";
				case TypePlanStatusEnum.Historical:
					return "Archiv";
				case TypePlanStatusEnum.Obsolete:
					return "Gelöscht";
			}
			return "";
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			if (value is string)
			{
				switch ((string)value)
				{
					case "Neu":
						return TypePlanStatusEnum.New;
					case "Forecast":
						return TypePlanStatusEnum.Plan;
					case "Budget":
						return TypePlanStatusEnum.Baseline;
					case "Archiv":
						return TypePlanStatusEnum.Historical;
					case "Gelöscht":
						return TypePlanStatusEnum.Obsolete;
				}
			}
			return null;
		}
	}

	public class TypePlanParameterConverter : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((TypePlanParameterEnum)value)
			{
				case TypePlanParameterEnum.ContingencyRate:
					return "Rate";
				case TypePlanParameterEnum.PriceFactor:
					return "Faktor";
				case TypePlanParameterEnum.TriggerDate:
					return "Datum";
			}
			return "";
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			if (value is string)
			{
				switch ((string)value)
				{
					case "Rate":
						return TypePlanParameterEnum.ContingencyRate;
					case "Faktor":
						return TypePlanParameterEnum.PriceFactor;
					case "Datum":
						return TypePlanParameterEnum.TriggerDate;
				}
			}
			return null;
		}
	}

	public class TypeSelector
	{
		public short TypeCode { get; set; }
		public string Title { get; set; }

		public TypeSelector( short code, string title)
        {
			TypeCode = code;
			Title = title;
        }
    }

	public class SortAdorner : Adorner
	{
		private static Geometry ascGeometry =
			Geometry.Parse("M 0 4 L 3.5 0 L 7 4 Z");

		private static Geometry descGeometry =
			Geometry.Parse("M 0 0 L 3.5 4 L 7 0 Z");

		public ListSortDirection Direction { get; private set; }

		public SortAdorner(UIElement element, ListSortDirection dir)
			: base(element)
		{
			this.Direction = dir;
		}

		protected override void OnRender(DrawingContext drawingContext)
		{
			base.OnRender(drawingContext);

			if (AdornedElement.RenderSize.Width < 20)
				return;

			TranslateTransform transform = new TranslateTransform
				(
					AdornedElement.RenderSize.Width - 15,
					(AdornedElement.RenderSize.Height - 5) / 2
				);
			drawingContext.PushTransform(transform);

			Geometry geometry = ascGeometry;
			if (this.Direction == ListSortDirection.Descending)
				geometry = descGeometry;
			drawingContext.DrawGeometry(Brushes.Black, null, geometry);

			drawingContext.Pop();
		}

	}
	public class TypeAcccountConverter : IValueConverter
	{

		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			return ((TypeAccountEnum)value).ToString();
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
            switch ((string)value)
            {
				case "P_L":
					return TypeAccountEnum.P_L;
				case "Assets":
					return TypeAccountEnum.Assets;
				case "Liabilities":
					return TypeAccountEnum.Liabilities;
				case "Other":
					return TypeAccountEnum.Other;
				default: return null;
			}
		}
	}

	public class TypeBookRecordConverter : IValueConverter
	{

		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			return ((TypeBookRecordEnum)value).ToString();
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((string)value)
			{
				case "Actual":
					return TypeBookRecordEnum.Actual;
				case "Baseline":
					return TypeBookRecordEnum.Budget;
				case "Plan":
					return TypeBookRecordEnum.Plan;
				case "New":
					return TypeBookRecordEnum.New;
				case "Historical":
					return TypeBookRecordEnum.Historical;
				case "Obsolete":
					return TypeBookRecordEnum.Obsolete;
				default: return null;
			}
		}
	}
}

