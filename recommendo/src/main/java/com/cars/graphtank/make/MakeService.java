package com.cars.graphtank.make;

import com.google.common.collect.Lists;

import java.util.List;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class MakeService {

    private MakeRepository makeRepo;

    private MakeService() {}

    public MakeService(MakeRepository makeRepo) {
        this.makeRepo = notNull(makeRepo, "Make Repo is required");
    }

    public Make findByMakeId(Long makeId) {
        notNull(makeId, "Make Id is required");
        MakeNode make = makeRepo.findByMakeId(makeId);
        return new Make(make);
    }

    public List<Make> findAllMakes() {
        Iterable<MakeNode> nodes = makeRepo.findAll();
        return flattenNodes(nodes);
    }

    private List<Make> flattenNodes(Iterable<MakeNode> nodes) {
        notNull(nodes, "Nodes can not be null");
        List<Make> makes = Lists.newArrayList();
        for (MakeNode node : nodes) {
            makes.add(new Make(node));
        }
        return makes;
    }
}
