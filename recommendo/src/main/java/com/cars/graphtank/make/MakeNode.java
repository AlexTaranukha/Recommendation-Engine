package com.cars.graphtank.make;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.year.YearNode;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.apache.commons.lang3.ObjectUtils;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.List;
import java.util.Set;

/**
 * Created by brendandite on 4/14/17.
 */
@NodeEntity(label = "Make")
public class MakeNode {

    private Long id;

    private Long makeId;

    private String name;

    @Relationship(type = "OF_YEAR")
    private List<YearNode> years = Lists.newArrayList();

    @Relationship(type = "OF_MAKE", direction = Relationship.INCOMING)
    private List<ModelNode> models = Lists.newArrayList();

    private MakeNode() {}

    public MakeNode(Long makeId, String name) {
        this.makeId = notNull(makeId, "Make ID is required");
        this.name = notEmpty(name, "Name is required");

    }

    public Long getId() {
        return id;
    }

    public Long getMakeId() {
        return makeId;
    }

    public void setMakeId(Long makeId) {
        this.makeId = notNull(makeId, "Make Id is required");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = notEmpty(name, "Name is required");
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

    public List<ModelNode> getModels() {
        return models;
    }

    public void setModels(List<ModelNode> models) {
        this.models = ObjectUtils.defaultIfNull(models, Lists.newArrayList());
    }
}
