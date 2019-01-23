package com.cars.graphtank.trim;

import static org.apache.commons.lang3.Validate.notNull;
import static org.apache.commons.lang3.Validate.notEmpty;

import com.cars.graphtank.model.ModelNode;
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
@NodeEntity(label = "Trim")
public class TrimNode {

    private Long id;

    private Long trimId;

    private String name;

    @Relationship(type = "OF_MODEL")
    private ModelNode model;

    @Relationship(type = "OF_YEAR")
    private List<YearNode> years = Lists.newArrayList();

    private TrimNode() {}

    public TrimNode(Long trimId, String name, ModelNode model) {
        this.trimId = notNull(trimId, "Trim ID is required");
        this.name = notEmpty(name, "Name is required");
        this.model = notNull(model, "Model is required");
    }

    public Long getId() {
        return id;
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
        this.name = notEmpty(name, "Name can not be empty");
    }

    public ModelNode getModel() {
        return model;
    }

    public void setModel(ModelNode model) {
        this.model = notNull(model, "Model is required");
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
}
