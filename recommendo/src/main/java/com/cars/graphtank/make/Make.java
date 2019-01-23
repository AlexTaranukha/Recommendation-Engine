package com.cars.graphtank.make;

import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.model.SimpleModel;
import com.cars.graphtank.year.SimpleYear;
import com.cars.graphtank.year.YearNode;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.ObjectUtils;

import java.util.List;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class Make extends SimpleMake {

    private List<SimpleModel> models = Lists.newArrayList();

    private List<SimpleYear> years = Lists.newArrayList();

    private Make() {}

    public Make(Long makeId, String name) {
        super(makeId, name);
    }

    public Make(MakeNode makeNode) {
        super(makeNode);
        setModelsListFromNodes(makeNode.getModels());
        setYearsListFromNodes(makeNode.getYears());
    }

    private final void setModelsListFromNodes(List<ModelNode> modelNodes) {
        notNull(modelNodes, "Trim nodes can not be null");
        models.clear();
        for (ModelNode modelNode : modelNodes) {
            models.add(new SimpleModel(modelNode.getModelId(), modelNode.getName()));
        }
    }

    private final void setYearsListFromNodes(List<YearNode> yearNodes) {
        notNull(yearNodes, "Year nodes can not be null");
        years.clear();
        for (YearNode yearNode : yearNodes) {
            years.add(new SimpleYear(yearNode.getYearId(), yearNode.getYear()));
        }
    }

    public List<SimpleModel> getModels() {
        return models;
    }

    public void setModels(List<SimpleModel> models) {
        this.models = ObjectUtils.defaultIfNull(models, Lists.newArrayList());
    }

    public List<SimpleYear> getYears() {
        return years;
    }

    public void setYears(List<SimpleYear> years) {
        this.years = ObjectUtils.defaultIfNull(years, Lists.newArrayList());
    }
}
