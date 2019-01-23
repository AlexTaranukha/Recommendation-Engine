package com.cars.graphtank.bodystyle;

import com.cars.graphtank.make.MakeNode;
import com.cars.graphtank.make.SimpleMake;
import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.model.SimpleModel;
import com.cars.graphtank.trim.SimpleTrim;
import com.cars.graphtank.trim.TrimNode;
import com.google.common.collect.Lists;

import java.util.List;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class Bodystyle {

    private Long bodystyleId;

    private String name;

    private List<SimpleMake> makes = Lists.newArrayList();

    private List<SimpleModel> models = Lists.newArrayList();

    private List<SimpleTrim> trims = Lists.newArrayList();

    private Bodystyle() {}

    public Bodystyle(Long bodystyleId, String name) {
        this.bodystyleId = notNull(bodystyleId, "Bodystyle Id is required");
        this.name = notEmpty(name, "Name is required");
    }

    public Bodystyle(BodystyleNode bodystyleNode) {
        notNull(bodystyleNode, "Bodystyle Node can not be null");
        this.bodystyleId = bodystyleNode.getBodystyleId();
        this.name = bodystyleNode.getName();
        setMakesListFromNodes(bodystyleNode.getMakes());
        setModelsListFromNodes(bodystyleNode.getModels());
        setTrimsListFromNodes(bodystyleNode.getTrims());
    }

    public Long getBodystyleId() {
        return bodystyleId;
    }

    public void setBodystyleId(Long bodystyleId) {
        this.bodystyleId = notNull(bodystyleId, "Bodystyle Id is required");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = notEmpty(name, "Name is required");
    }

    private final void setMakesListFromNodes(List<MakeNode> makeNodes) {
        makes.clear();
        for (MakeNode makeNode : makeNodes) {
            makes.add(new SimpleMake(makeNode.getMakeId(), makeNode.getName()));
        }
    }

    private final void setModelsListFromNodes(List<ModelNode> modelNodes) {
        models.clear();

        for (ModelNode modelNode : modelNodes) {
            models.add(new SimpleModel(modelNode.getModelId(), modelNode.getName()));
        }
    }

    private final void setTrimsListFromNodes(List<TrimNode> trimNodes) {
        trims.clear();
        for (TrimNode trimNode : trimNodes) {
            trims.add(new SimpleTrim(trimNode.getTrimId(), trimNode.getName()));
        }
    }
}
