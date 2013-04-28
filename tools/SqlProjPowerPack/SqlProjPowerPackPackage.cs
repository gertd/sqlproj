//------------------------------------------------------------------------------
// <copyright>
//	 Copyright (c) SQLproj.com.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
namespace SqlProj.Tools.PowerPack
{
    using System;
    using System.ComponentModel.Design;
    using System.Diagnostics;
    using System.Globalization;
    using System.Runtime.InteropServices;
    using Microsoft.VisualStudio;
    using Microsoft.VisualStudio.Shell;
    using Microsoft.VisualStudio.Shell.Interop;

    [PackageRegistration(UseManagedResourcesOnly = true)]
    [InstalledProductRegistration("#110", "#112", "1.0", IconResourceID = 400)]
    [ProvideMenuResource("Menus.ctmenu", 1)]
    [Guid(GuidList.guidSqlProjPowerPackPkgString)]
    [ProvideAutoLoad(GuidList.guidSqlProjProjectString)]
    public sealed class SqlProjPowerPackPackage : Package
    {
        private static SqlProjPowerPackPackage _instance;

        SolutionEvents solutionEvents = new SolutionEvents();
        SelectionEvents selectionEvents = new SelectionEvents();

        bool visible = false;

        public SqlProjPowerPackPackage()
        {
            Trace.WriteLine(string.Format(CultureInfo.CurrentCulture, "Entering constructor for: {0}", this.ToString()));
        }

        protected override void Initialize()
        {
            Trace.WriteLine (string.Format(CultureInfo.CurrentCulture, "Entering Initialize() of: {0}", this.ToString()));
            base.Initialize();

            // Add our command handlers for menu (commands must exist in the .vsct file)
            OleMenuCommandService mcs = GetService(typeof(IMenuCommandService)) as OleMenuCommandService;
            if ( null != mcs )
            {
                {
                    // Create the command for the menu item.
                    CommandID menuCommandID = new CommandID(GuidList.guidSqlProjPowerPackCmdSet, (int)PkgCmdIDList.cmdIdTest);
                    MenuCommand menuItem = new MenuCommand(OnTestCallback, menuCommandID);
                    mcs.AddCommand(menuItem);
                }
                {
                    // Create the command for the menu item.
                    CommandID menuCommandID = new CommandID(GuidList.guidSqlProjPowerPackCmdSet, (int)PkgCmdIDList.cmdIdImportDBSchema);
                    OleMenuCommand menuItem = new OleMenuCommand(OnImportDBSchemaCallback, menuCommandID);

                    menuItem.BeforeQueryStatus += new EventHandler((sender, e) =>
                        {
                            MenuCommand menuCommand = sender as OleMenuCommand;
                            if (menuCommand != null)
                            {
                                bool isSqlProj = ProjectHelper.IsSqlProj(selectionEvents.GetSelectedProject());
                                menuCommand.Visible = isSqlProj;
                                menuCommand.Enabled = isSqlProj;
                            }
                            Debug.WriteLine(String.Format("BeforeQueryStatus = {0}", visible.ToString()));
                        });

                    mcs.AddCommand(menuItem);
                }
            }
            _instance = this;
        }

        private void OnTestCallback(object sender, EventArgs e)
        {
            visible = !visible;
        }

        private void OnImportDBSchemaCallback(object sender, EventArgs e)
        {
            // Show a Message Box to prove we were here
            IVsUIShell uiShell = (IVsUIShell)GetService(typeof(SVsUIShell));
            Guid clsid = Guid.Empty;
            int result;
            Microsoft.VisualStudio.ErrorHandler.ThrowOnFailure(uiShell.ShowMessageBox(
                       0,
                       ref clsid,
                       "SqlProjPowerPack",
                       string.Format(CultureInfo.CurrentCulture, "Inside {0}.MenuItemCallback()", this.ToString()),
                       string.Format(CultureInfo.CurrentCulture, "Visible = {0} ", this.visible),
                       0,
                       OLEMSGBUTTON.OLEMSGBUTTON_OK,
                       OLEMSGDEFBUTTON.OLEMSGDEFBUTTON_FIRST,
                       OLEMSGICON.OLEMSGICON_INFO,
                       0,        // false
                       out result));
        }

        internal static SqlProjPowerPackPackage Instance
        {
            get
            {
                if (_instance == null)
                {
                    // Force this package to load
                    IVsPackage package;
                    DemandLoadPackage(out package);
                }
                return _instance;
            }
        }

        public static void DemandLoadPackage(out IVsPackage package)
        {
            package = null;
            IVsShell shell = GetGlobalService(typeof(SVsShell)) as IVsShell;
            if (shell != null)
            {
                Guid packageGuid = new Guid(GuidList.guidSqlProjPowerPackPkgString);
                ErrorHandler.ThrowOnFailure(shell.LoadPackage(ref packageGuid, out package));
            }
        }
    }
}
