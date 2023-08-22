/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.harvard.iq.dataverse.engine.command.impl;

import edu.harvard.iq.dataverse.Dataset;
import edu.harvard.iq.dataverse.DatasetVersion;
import edu.harvard.iq.dataverse.authorization.Permission;
import edu.harvard.iq.dataverse.engine.command.AbstractCommand;
import edu.harvard.iq.dataverse.engine.command.CommandContext;
import edu.harvard.iq.dataverse.engine.command.DataverseRequest;
import edu.harvard.iq.dataverse.engine.command.RequiredPermissions;
import edu.harvard.iq.dataverse.engine.command.exception.CommandException;
import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Naomi
 */
// No permission needed to view published dvObjects
@RequiredPermissions({})
public class ListVersionsCommand extends AbstractCommand<List<DatasetVersion>> {

    private final Dataset ds;
    private final Integer limit; 
    private final Integer offset;
    
    public ListVersionsCommand(DataverseRequest aRequest, Dataset aDataset) {
        this(aRequest, aDataset, null, null);
    }

    public ListVersionsCommand(DataverseRequest aRequest, Dataset aDataset, Integer offset, Integer limit) {
        super(aRequest, aDataset);
        ds = aDataset;
        this.offset = offset; 
        this.limit = limit; 
    }

    @Override
    public List<DatasetVersion> execute(CommandContext ctxt) throws CommandException {
        
        boolean includeUnpublished = ctxt.permissions().request(getRequest()).on(ds).has(Permission.EditDataset);
        
        if (offset == null && limit == null) {
            // @todo: this fragment can be dropped, and the service-based method below 
            // can be used for both cases.
            // @todo: on the other hand, consider using datasetservice.findDeep()
            // when a full list of versions is requested. 
            List<DatasetVersion> outputList = new LinkedList<>();
            for (DatasetVersion dsv : ds.getVersions()) {
                if (dsv.isReleased() || includeUnpublished) {
                    outputList.add(dsv);
                }
            }
            return outputList;
        } else {
            // Only a partial list (one "page"-worth) of versions is being requested
            return ctxt.datasetVersion().findVersions(ds.getId(), offset, limit, includeUnpublished);
        }
    }
}
