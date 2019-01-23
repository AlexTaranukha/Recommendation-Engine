package com.cars.graphtank.model;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class SimpleModel {

    private Long modelId;

    private String name;

    SimpleModel() {}

    public SimpleModel(Long modelId, String name) {
        this.modelId = notNull(modelId, "Model Id is required");
        this.name = notEmpty(name, "Name is required");
    }

    public SimpleModel(ModelNode modelNode) {
        notNull(modelNode, "Model Node can not be null");
        this.modelId = modelNode.getModelId();
        this.name = modelNode.getName();
    }

    public Long getModelId() {
        return modelId;
    }

    public void setModelId(Long modelId) {
        this.modelId = notNull(modelId, "Model Id is required");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = notEmpty(name, "Name is required");
    }
}
