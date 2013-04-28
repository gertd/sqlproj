//------------------------------------------------------------------------------
// <copyright>
//	 Copyright (c) SQLproj.com.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
namespace SqlProj.Tools.PowerPack
{
    using System.Diagnostics;
    using Microsoft.VisualStudio;
    using Microsoft.VisualStudio.Shell;
    using Microsoft.VisualStudio.Shell.Interop;

    internal class SolutionEvents : IVsSolutionEvents3, IVsSolutionEvents4
    {
        private static IVsSolution solution;
        private uint cookie;

        static SolutionEvents()
        {
            solution = Package.GetGlobalService(typeof(SVsSolution)) as IVsSolution;
        }

        public SolutionEvents()
        {
            solution.AdviseSolutionEvents(this, out cookie);
        }  

        public int OnAfterCloseSolution(object pUnkReserved)
        {
            Debug.WriteLine("OnAfterCloseSolution");
            return VSConstants.S_OK; 
        }

        public int OnAfterLoadProject(IVsHierarchy pStubHierarchy, IVsHierarchy pRealHierarchy)
        {
            Debug.WriteLine("OnAfterLoadProject");
            return VSConstants.S_OK; 
        }

        public int OnAfterOpenProject(IVsHierarchy pHierarchy, int fAdded)
        {
            Debug.WriteLine("OnAfterOpenProject");
            return VSConstants.S_OK; 
        }

        public int OnAfterOpenSolution(object pUnkReserved, int fNewSolution)
        {
            Debug.WriteLine("OnAfterOpenSolution");
            return VSConstants.S_OK; 
        }

        public int OnBeforeCloseProject(IVsHierarchy pHierarchy, int fRemoved)
        {
            Debug.WriteLine("OnBeforeCloseProject");
            return VSConstants.S_OK; 
        }

        public int OnBeforeCloseSolution(object pUnkReserved)
        {
            Debug.WriteLine("OnBeforeCloseSolution");
            return VSConstants.S_OK; 
        }

        public int OnBeforeUnloadProject(IVsHierarchy pRealHierarchy, IVsHierarchy pStubHierarchy)
        {
            Debug.WriteLine("OnBeforeUnloadProject");
            return VSConstants.S_OK; 
        }

        public int OnQueryCloseProject(IVsHierarchy pHierarchy, int fRemoving, ref int pfCancel)
        {
            Debug.WriteLine("OnQueryCloseProject");
            return VSConstants.S_OK; 
        }

        public int OnQueryCloseSolution(object pUnkReserved, ref int pfCancel)
        {
            Debug.WriteLine("OnQueryCloseSolution");
            return VSConstants.S_OK; 
        }

        public int OnQueryUnloadProject(IVsHierarchy pRealHierarchy, ref int pfCancel)
        {
            Debug.WriteLine("OnQueryUnloadProject");
            return VSConstants.S_OK; 
        }


        public int OnAfterClosingChildren(IVsHierarchy pHierarchy)
        {
            Debug.WriteLine("OnAfterClosingChildren");
            return VSConstants.S_OK; 
        }

        public int OnAfterMergeSolution(object pUnkReserved)
        {
            Debug.WriteLine("OnAfterMergeSolution");
            return VSConstants.S_OK; 
        }

        public int OnAfterOpeningChildren(IVsHierarchy pHierarchy)
        {
            Debug.WriteLine("OnAfterOpeningChildren");
            return VSConstants.S_OK; 
        }

        public int OnBeforeClosingChildren(IVsHierarchy pHierarchy)
        {
            Debug.WriteLine("OnBeforeClosingChildren");
            return VSConstants.S_OK; 
        }

        public int OnBeforeOpeningChildren(IVsHierarchy pHierarchy)
        {
            Debug.WriteLine("OnBeforeOpeningChildren");
            return VSConstants.S_OK; 
        }

        public int OnAfterAsynchOpenProject(IVsHierarchy pHierarchy, int fAdded)
        {
            Debug.WriteLine("OnAfterAsynchOpenProject");
            return VSConstants.S_OK; 
        }

        public int OnAfterChangeProjectParent(IVsHierarchy pHierarchy)
        {
            Debug.WriteLine("OnAfterChangeProjectParent");
            return VSConstants.S_OK; 
        }

        public int OnAfterRenameProject(IVsHierarchy pHierarchy)
        {
            Debug.WriteLine("OnAfterRenameProject");
            return VSConstants.S_OK; 
        }

        public int OnQueryChangeProjectParent(IVsHierarchy pHierarchy, IVsHierarchy pNewParentHier, ref int pfCancel)
        {
            Debug.WriteLine("OnQueryChangeProjectParent");
            return VSConstants.S_OK; 
        }
    }
}
