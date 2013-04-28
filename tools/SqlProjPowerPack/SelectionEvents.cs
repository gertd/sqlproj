//------------------------------------------------------------------------------
// <copyright>
//	 Copyright (c) SQLproj.com.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
namespace SqlProj.Tools.PowerPack
{
    using System;
    using System.Runtime.InteropServices;
    using Microsoft.VisualStudio;
    using Microsoft.VisualStudio.Shell;
    using Microsoft.VisualStudio.Shell.Interop;

    internal class SelectionEvents : IVsSelectionEvents
    {
        private static IVsMonitorSelection monitorSelection;
        private uint cookie;

        static SelectionEvents()
        {
            monitorSelection = (IVsMonitorSelection) Package.GetGlobalService(typeof(SVsShellMonitorSelection));
        }

        public SelectionEvents()
        {
            monitorSelection.AdviseSelectionEvents(this, out cookie);
        }

        public EnvDTE.Project GetSelectedProject()
        {
            IntPtr hierarchyPtr, selectionContainerPtr;
            Object prjItemObject  = null;
            IVsMultiItemSelect multiItemSelect;
            uint selectedItemId;
            
            // IVsMonitorSelection monitorSelection = (IVsMonitorSelection)Package.GetGlobalService(typeof(SVsShellMonitorSelection));
            monitorSelection.GetCurrentSelection(out hierarchyPtr, out selectedItemId, out multiItemSelect, out selectionContainerPtr);
            IVsHierarchy selectedHierarchy = Marshal.GetTypedObjectForIUnknown(hierarchyPtr, typeof(IVsHierarchy)) as IVsHierarchy;
            if (selectedHierarchy != null)
            {
                ErrorHandler.ThrowOnFailure(selectedHierarchy.GetProperty(selectedItemId, (int)__VSHPROPID.VSHPROPID_ExtObject, out prjItemObject));
            }
            EnvDTE.Project selectedProject = prjItemObject as EnvDTE.Project;
            return selectedProject;
        }

        public int OnCmdUIContextChanged(uint dwCmdUICookie, int fActive)
        {
            return VSConstants.S_OK; 
        }

        public int OnElementValueChanged(uint elementid, object varValueOld, object varValueNew)
        {
            return VSConstants.S_OK; 
        }

        public int OnSelectionChanged(IVsHierarchy pHierOld, uint itemidOld, IVsMultiItemSelect pMISOld, ISelectionContainer pSCOld, IVsHierarchy pHierNew, uint itemidNew, IVsMultiItemSelect pMISNew, ISelectionContainer pSCNew)
        {
            return VSConstants.S_OK; 
        }
    }
}
