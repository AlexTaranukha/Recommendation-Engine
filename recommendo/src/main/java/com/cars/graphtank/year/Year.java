package com.cars.graphtank.year;

import com.cars.graphtank.make.MakeNode;
import com.cars.graphtank.make.SimpleMake;
import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.model.SimpleModel;
import com.cars.graphtank.trim.SimpleTrim;
import com.cars.graphtank.trim.TrimNode;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.ObjectUtils;

import java.util.List;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/20/17.
 */
public class Year extends SimpleYear {

    private List<SimpleMake> makes = Lists.newArrayList();

    private List<SimpleModel> models = Lists.newArrayList();

    private List<SimpleTrim> trims = Lists.newArrayList();

    private Year() {}

    public Year(Long yearId, Integer year) {
        super(yearId, year);
    }

    public Year(YearNode yearNode) {
        super(yearNode);
        setMakesListFromNodes(yearNode.getMakes());
        setModelsListFromNodes(yearNode.getModels());
        setTrimsListFromNodes(yearNode.getTrims());
    }

    private final void setMakesListFromNodes(List<MakeNode> makeNodes) {
        notNull(makeNodes, "Make nodes can not be null");
        makes.clear();
        for (MakeNode makeNode : makeNodes) {
            makes.add(new SimpleMake(makeNode.getMakeId(), makeNode.getName()));
        }
    }

    private final void setModelsListFromNodes(List<ModelNode> modelNodes) {
        notNull(modelNodes, "Model nodes can not be null");
        models.clear();
        for (ModelNode modelNode : modelNodes) {
            models.add(new SimpleModel(modelNode.getModelId(), modelNode.getName()));
        }
    }

    private final void setTrimsListFromNodes(List<TrimNode> trimNodes) {
        notNull(trimNodes, "Trim nodes can not be null");
        trims.clear();
        for (TrimNode trimNode : trimNodes) {
            trims.add(new SimpleTrim(trimNode.getTrimId(), trimNode.getName()));
        }
    }

    public List<SimpleMake> getMakes() {
        return makes;
    }

    public void setMakes(List<SimpleMake> makes) {
        this.makes = ObjectUtils.defaultIfNull(makes, Lists.newArrayList());
    }

    public List<SimpleModel> getModels() {
        return models;
    }

    public void setModels(List<SimpleModel> models) {
        this.models = ObjectUtils.defaultIfNull(models, Lists.newArrayList());
    }

    public List<SimpleTrim> getTrims() {
        return trims;
    }

    public void setTrims(List<SimpleTrim> trims) {
        this.trims = ObjectUtils.defaultIfNull(trims, Lists.newArrayList());
    }
}
