package com.cars.graphtank.trim;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class SimpleTrim {

    private Long trimId;

    private String name;

    SimpleTrim() {}

    public SimpleTrim(Long trimId, String name) {
        this.trimId = notNull(trimId, "Trim Id is required");
        this.name = notEmpty(name, "Name is required");
    }

    public SimpleTrim(TrimNode trimNode) {
        notNull(trimNode, "Trim Node can not be null");
        this.trimId = notNull(trimNode.getTrimId(), "Trim Id is required");
        this.name = notEmpty(trimNode.getName(), "Name is required");
    }

    public Long getTrimId() {
        return trimId;
    }

    public void setTrimId(Long trimId) {
        this.trimId = notNull(trimId, "Trim Id is required");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = notEmpty(name, "Name is required");
    }
}
