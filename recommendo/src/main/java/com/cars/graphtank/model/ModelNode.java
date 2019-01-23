package com.cars.graphtank.model;

import static org.apache.commons.lang3.Validate.notNull;
import static org.apache.commons.lang3.Validate.notEmpty;

import com.cars.graphtank.make.MakeNode;
import com.cars.graphtank.trim.TrimNode;
import com.cars.graphtank.year.YearNode;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.ObjectUtils;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.List;

/**
 * Created by brendandite on 4/14/17.
 */
@NodeEntity(label = "Model")
public class ModelNode {

    private Long id;

    private Long modelId;

    private String name;

    @Relationship(type = "OF_MAKE")
    MakeNode make;

    @Relationship(type = "OF_YEAR")
    List<YearNode> years = Lists.newArrayList();

    @Relationship(type = "OF_MODEL", direction = Relationship.INCOMING)
    List<TrimNode> trims = Lists.newArrayList();

    private ModelNode() {}

    public ModelNode(Long modelId, String name, MakeNode make) {
        this.modelId = notNull(modelId, "Model ID is required");
        this.name = notEmpty(name, "Name is required");
        this.make = notNull(make, "Make is required");
    }

    public Long getId() {
        return id;
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

    public MakeNode getMake() {
        return make;
    }

    public void setMake(MakeNode make) {
        this.make = notNull(make, "Make is required");
    }

    public List<YearNode> getYears() {
        return years;
    }

    public void setYears(List<YearNode> years) {
        this.years = ObjectUtils.defaultIfNull(years, Lists.newArrayList());
    }

    public void addYear(YearNode year) {
        notNull(year, "Year can not be null");
        years.add(year);
    }

    public List<TrimNode> getTrims() {
        return trims;
    }

    public void setTrims(List<TrimNode> trims) {
        this.trims = ObjectUtils.defaultIfNull(trims, Lists.newArrayList());
    }
}
