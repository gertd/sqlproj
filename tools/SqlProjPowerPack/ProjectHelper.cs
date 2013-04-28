//------------------------------------------------------------------------------
// <copyright>
//	 Copyright (c) SQLproj.com.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
namespace SqlProj.Tools.PowerPack
{
    using System;
    using System.Collections.Generic;
    using EnvDTE80;
    using Microsoft.VisualStudio;
    using Microsoft.VisualStudio.Shell.Interop;

    static class ProjectHelper
    {
        public static bool IsSqlProj(EnvDTE.Project project)
        {
            if (project != null)
            {
                string kind = project.Kind;
                if (string.IsNullOrEmpty(kind) == false)
                {
                    Guid thisProjectGuid = new Guid(kind);
                    Guid databaseProjectGuid = new Guid(GuidList.guidSqlProjProjectString);

                    if (thisProjectGuid.CompareTo(databaseProjectGuid) == 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        public static bool IsSqlProj(IVsHierarchy hierarchy)
        {
            var project = GetProject(hierarchy);
            string kind = project.Kind;
            if (string.IsNullOrEmpty(kind) == false)
            {
                Guid projectGuid = new Guid(kind);
                Guid sqlProjGuid = new Guid(GuidList.guidSqlProjProjectString);

                if (projectGuid.CompareTo(sqlProjGuid) == 0)
                {
                    return true;
                }
            }
            return false;
        }

        public static bool IsDatabaseProjectSelected(DTE2 applicationObject)
        {
            return GetDatabaseProjects(applicationObject).Count != 0;
        }

        public static IList<EnvDTE.Project> GetDatabaseProjects(DTE2 applicationObject)
        {
            IList<EnvDTE.Project> foundProjects = new List<EnvDTE.Project>();

            foreach (EnvDTE.Project proj in applicationObject.Solution.Projects)
            {
                EnvDTE.Project thisProject = proj as EnvDTE.Project;
                if (thisProject != null)
                {
                    string kind = thisProject.Kind;
                    if (string.IsNullOrEmpty(kind) == false)
                    {
                        Guid thisProjectGuid = new Guid(kind);
                        Guid databaseProjectGuid = new Guid(GuidList.guidSqlProjProjectString);

                        if (thisProjectGuid.CompareTo(databaseProjectGuid) == 0)
                        {
                            foundProjects.Add(thisProject);
                        }
                    }
                }
            }
            return foundProjects;
        }

        public static EnvDTE.Project GetProject(IVsHierarchy hierarchy)
        {
            object project;
            
            ErrorHandler.ThrowOnFailure(hierarchy.GetProperty(VSConstants.VSITEMID_ROOT, (int)__VSHPROPID.VSHPROPID_ExtObject, out project));
            return (project as EnvDTE.Project);
        }

        public static IVsHierarchy GetIVsHierarchy(IServiceProvider serviceProvider, EnvDTE.Project project)
        {
            var solution = serviceProvider.GetService(typeof(SVsSolution)) as IVsSolution;
            IVsHierarchy hierarchy;
            solution.GetProjectOfUniqueName(project.FullName, out hierarchy);
            return hierarchy;
        }
    }
}
