using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Input;

namespace VerumDesk
{
	public static class VerumCommands
	{
		public static readonly RoutedUICommand Exit = new RoutedUICommand
		(
			"Exit",
			"Exit",
			typeof(VerumCommands),
			new InputGestureCollection()
			{
				new KeyGesture(Key.F4, ModifierKeys.Alt)
			}
		);

		public static readonly RoutedUICommand BookingRunImport = new RoutedUICommand
		(
			"Buchungen importieren",
			"BookingRunImport",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand CostCenterList = new RoutedUICommand
		(
			"Kostenstellen bearbeiten",
			"CostCenterList",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand JobList = new RoutedUICommand
		(
			"Jobs prüfen",
			"JobList",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand PlanEdit = new RoutedUICommand
		(
			"Plan bearbeiten",
			"PlanEdit",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand PlanImplement = new RoutedUICommand
		(
			"Planung implementieren",
			"PlanImplement",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand UserAdmin = new RoutedUICommand
		(
			"Benutzer verwalten",
			"UserAdmin",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand ReferenceCodeList = new RoutedUICommand
		(
			"Buchungsschlüssel verwalten",
			"ReferenceCodeList",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand ReferenceGroupList = new RoutedUICommand
		(
			"Buchungsschlüsselgruppen verwalten",
			"ReferenceGroupList",
			typeof(VerumCommands)
		);

		public static readonly RoutedUICommand AccountList = new RoutedUICommand
		(
			"Konten verwalten",
			"AccountList",
			typeof(VerumCommands)
		);
		public static readonly RoutedUICommand AccountGroupList = new RoutedUICommand
		(
			"Kontogruppen verwalten",
			"AccountGroupList",
			typeof(VerumCommands)
		);
		public static readonly RoutedUICommand AccountMainGroupList = new RoutedUICommand
		(
			"Kontohauptgruppen verwalten",
			"AccountMainGroupList",
			typeof(VerumCommands)
		);
		public static readonly RoutedUICommand AccountSectionList = new RoutedUICommand
		(
			"Kontosektionen verwalten",
			"AccountSectionList",
			typeof(VerumCommands)
		);
		public static readonly RoutedUICommand BookingRunList = new RoutedUICommand
		(
			"Journale anzeigen",
			"BookingRunList",
			typeof(VerumCommands)
		);
		public static readonly RoutedUICommand DepreciationRuleList = new RoutedUICommand
		(
			"Abschreibungsregeln anzeigen",
			"DepreciationRuleList",
			typeof(VerumCommands)
		);
		public static readonly RoutedUICommand PlanImport = new RoutedUICommand
		(
			"Pläne Importieren",
			"PlanImport",
			typeof(VerumCommands)
		);
	}
}