package com.cars.graphtank.vehicletype;

import static org.apache.commons.lang3.Validate.notNull;

import com.cars.graphtank.make.MakeNode;
import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.trim.TrimNode;
import com.cars.graphtank.year.YearNode;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

/**
 * Created by brendandite on 4/14/17.
 */
@NodeEntity(label = "VehicleType")
public class VehicleTypeNode {

    private Long id;

    private Long vehicleTypeId;

    @Relationship(type = "OF_MAKE")
    private MakeNode make;

    @Relationship(type = "OF_MODEL")
    private ModelNode model;

    @Relationship(type = "OF_TRIM")
    private TrimNode trim;

    @Relationship(type = "OF_YEAR")
    private YearNode year;

    private VehicleTypeNode() {}

    public VehicleTypeNode(Long vehicleTypeId, MakeNode make, ModelNode model, TrimNode trim, YearNode year) {
        this.vehicleTypeId = notNull(vehicleTypeId, "Vehicle Type ID can not be null");
        this.make = notNull(make, "MakeNode is required");
        this.model = notNull(model, "ModelNode is required");
        this.trim = notNull(trim, "TrimNode is required");
        this.year = notNull(year, "YearNode is required");
    }

    public Long getId() {
        return id;
    }

    public Long getVehicleTypeId() {
        return vehicleTypeId;
    }

    public void setVehicleTypeId(Long vehicleTypeId) {
        this.vehicleTypeId = notNull(vehicleTypeId, "Vehicle Type ID can not be null");
    }

    public MakeNode getMake() {
        return make;
    }

    public void setMake(MakeNode make) {
        this.make = notNull(make, "Make is required");
    }

    public ModelNode getModel() {
        return model;
    }

    public void setModel(ModelNode model) {
        this.model = notNull(model, "Model is required");
    }

    public TrimNode getTrim() {
        return trim;
    }

    public void setTrim(TrimNode trim) {
        this.trim = notNull(trim, "Trim is required");
    }

    public YearNode getYear() {
        return year;
    }

    public void setYear(YearNode year) {
        this.year = notNull(year, "Year is required");
    }
}
