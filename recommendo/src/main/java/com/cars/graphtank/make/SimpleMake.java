package com.cars.graphtank.make;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class SimpleMake {

    private Long makeId;

    private String name;

    SimpleMake() {}

    public SimpleMake(Long makeId, String name) {
        this.makeId = notNull(makeId, "Make Id is required");
        this.name = notEmpty(name, "Name is required");
    }

    public SimpleMake(MakeNode makeNode) {
        notNull(makeNode, "Make Node can not be null");
        this.makeId = makeNode.getMakeId();
        this.name = makeNode.getName();
    }

    public Long getMakeId() {
        return makeId;
    }

    public final void setMakeId(Long makeId) {
        this.makeId = notNull(makeId, "Make Id is required");
    }

    public String getName() {
        return name;
    }

    public final void setName(String name) {
        this.name = notEmpty(name, "Name is required");
    }
}
