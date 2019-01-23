package com.cars.graphtank.bodystyle;

import com.google.common.collect.Lists;

import java.util.List;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class BodystyleService {

    private BodystyleRepository bodystyleRepo;

    private BodystyleService() {}

    public BodystyleService(BodystyleRepository bodystyleRepo) {
        this.bodystyleRepo = notNull(bodystyleRepo, "Bodystyle Repo is required");
    }

    public List<Bodystyle> findAllBodystyles() {
        Iterable<BodystyleNode> nodes = bodystyleRepo.findAll();
        return flattenNodes(nodes);
    }

    private List<Bodystyle> flattenNodes(Iterable<BodystyleNode> nodes) {
        notNull(nodes, "Bodystyle Nodes can not be null");
        List<Bodystyle> bodystyles = Lists.newArrayList();
        for (BodystyleNode bodystyleNode : nodes) {
            bodystyles.add(new Bodystyle(bodystyleNode));
        }
        return bodystyles;
    }

}
