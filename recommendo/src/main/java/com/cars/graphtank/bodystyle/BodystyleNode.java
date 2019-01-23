package com.cars.graphtank.bodystyle;

import com.cars.graphtank.make.MakeNode;
import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.trim.TrimNode;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.ObjectUtils;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.List;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
@NodeEntity(label = "bodystyle")
public class BodystyleNode {

    private Long id;

    private Long bodystyleId;

    private String name;

    @Relationship(type = "OF_BODYSTYLE", direction = Relationship.INCOMING)
    private List<MakeNode> makes = Lists.newArrayList();

    @Relationship(type = "OF_BODYSTYLE", direction = Relationship.INCOMING)
    private List<ModelNode> models = Lists.newArrayList();

    @Relationship(type = "OF_BODYSTYLE", direction = Relationship.INCOMING)
    private List<TrimNode> trims = Lists.newArrayList();

    private BodystyleNode() {}

    public BodystyleNode(Long bodystyleId, String name) {
        this.bodystyleId = notNull(bodystyleId, "Bodystyle Id is required");
        this.name = notEmpty(name, "Name is required");
    }

    public Long getId() {
        return id;
    }

    public Long getBodystyleId() {
        return bodystyleId;
    }

    public void setBodystyleId(Long bodystyleId) {
        this.bodystyleId = notNull(bodystyleId, "Bodystyle Id can not be null");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = notEmpty(name, "Name can not be null/empty");
    }

    public List<MakeNode> getMakes() {
        return makes;
    }

    public void setMakes(List<MakeNode> makes) {
        this.makes = ObjectUtils.defaultIfNull(makes, Lists.newArrayList());
    }

    public List<ModelNode> getModels() {
        return models;
    }

    public void setModels(List<ModelNode> models) {
        this.models = ObjectUtils.defaultIfNull(models, Lists.newArrayList());
    }

    public List<TrimNode> getTrims() {
        return trims;
    }

    public void setTrims(List<TrimNode> trims) {
        this.trims = ObjectUtils.defaultIfNull(trims, Lists.newArrayList());
    }
}
