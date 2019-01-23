package com.cars.graphtank.model;

import com.cars.graphtank.make.SimpleMake;
import com.cars.graphtank.trim.SimpleTrim;
import com.cars.graphtank.trim.TrimNode;
import com.cars.graphtank.year.SimpleYear;
import com.cars.graphtank.year.YearNode;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.ObjectUtils;

import java.util.List;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class Model extends SimpleModel {

    private SimpleMake make;

    private List<SimpleYear> years = Lists.newArrayList();

    private List<SimpleTrim> trims = Lists.newArrayList();

    private Model() {}

    public Model(Long modelId, String name, SimpleMake make) {
        super(modelId, name);
        this.make = notNull(make, "Make can not be null");
    }

    public Model(ModelNode modelNode) {
        super(modelNode);
        this.make = new SimpleMake(modelNode.getMake());
        setTrimsListFromNodes(modelNode.getTrims());
        setYearsListFromNodes(modelNode.getYears());
    }

    private final void setTrimsListFromNodes(List<TrimNode> trimNodes) {
        notNull(trimNodes, "Trim nodes can not be null");
        trims.clear();
        for (TrimNode trimNode : trimNodes) {
            trims.add(new SimpleTrim(trimNode.getTrimId(), trimNode.getName()));
        }
    }

    private final void setYearsListFromNodes(List<YearNode> yearNodes) {
        notNull(yearNodes, "Year nodes can not be null");
        years.clear();
        for (YearNode yearNode : yearNodes) {
            years.add(new SimpleYear(yearNode.getYearId(), yearNode.getYear()));
        }
    }

    public SimpleMake getMake() {
        return make;
    }

    public void setMake(SimpleMake make) {
        this.make = notNull(make, "Make can not be null");
    }

    public List<SimpleYear> getYears() {
        return years;
    }

    public void setYears(List<SimpleYear> years) {
        this.years = ObjectUtils.defaultIfNull(years, Lists.newArrayList());
    }

    public List<SimpleTrim> getTrims() {
        return trims;
    }

    public void setTrims(List<SimpleTrim> trims) {
        this.trims = ObjectUtils.defaultIfNull(trims, Lists.newArrayList());
    }
}
