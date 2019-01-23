package com.cars.graphtank.year;

import com.cars.graphtank.make.MakeNode;
import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.trim.TrimNode;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.ObjectUtils;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.List;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/14/17.
 */
//@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
@NodeEntity(label = "Year")
public class YearNode {

    Long id;

    Long yearId;

    Integer year;

    @Relationship(type = "OF_YEAR", direction = Relationship.INCOMING)
    List<MakeNode> makes = Lists.newArrayList();

    @Relationship(type = "OF_YEAR", direction = Relationship.INCOMING)
    List<ModelNode> models = Lists.newArrayList();

    @Relationship(type = "OF_YEAR", direction = Relationship.INCOMING)
    List<TrimNode> trims = Lists.newArrayList();

    private YearNode() {}

    public YearNode(Long yearId, Integer year) {
        this.yearId = notNull(yearId, "Year ID is required");
        this.year = notNull(year, "Year value is required");
    }

    public Long getId() {
        return id;
    }

    public Long getYearId() {
        return yearId;
    }

    public void setYearId(Long yearId) {
        this.yearId = notNull(yearId, "Year ID is required");
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = notNull(year, "Year value is required");
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
