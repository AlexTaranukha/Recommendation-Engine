package com.cars.graphtank.vehicletype;

import com.cars.graphtank.make.SimpleMake;
import com.cars.graphtank.model.SimpleModel;
import com.cars.graphtank.trim.SimpleTrim;
import com.cars.graphtank.year.SimpleYear;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/20/17.
 */
public class VehicleType {

    private Long vehicleTypeId;

    private SimpleMake make;

    private SimpleModel model;

    private SimpleTrim trim;

    private SimpleYear year;

    private VehicleType() {}

    public VehicleType(Long vehicleTypeId, SimpleMake make, SimpleModel model, SimpleTrim trim, SimpleYear year) {
        this.vehicleTypeId = notNull(vehicleTypeId, "Vehicle Type ID can not be null");
        this.make = notNull(make, "Make can not be null");
        this.model = notNull(model, "Model can not be null");
        this.trim = notNull(trim, "Trim can not be null");
        this.year = notNull(year, "Year can not be null");
    }

    public VehicleType(VehicleTypeNode vehicleTypeNode) {
        notNull(vehicleTypeNode, "Vehicle Type Node can not be null");
        this.vehicleTypeId = vehicleTypeNode.getVehicleTypeId();
        this.make = new SimpleMake(vehicleTypeNode.getMake());
        this.model = new SimpleModel(vehicleTypeNode.getModel());
        this.trim = new SimpleTrim(vehicleTypeNode.getTrim());
        this.year = new SimpleYear(vehicleTypeNode.getYear());
    }

    public Long getVehicleTypeId() {
        return vehicleTypeId;
    }

    public void setVehicleTypeId(Long vehicleTypeId) {
        this.vehicleTypeId = notNull(vehicleTypeId, "Vehicle Type ID can not be null");
    }

    public SimpleMake getMake() {
        return make;
    }

    public void setMake(SimpleMake make) {
        this.make = notNull(make, "Make can not be null");
    }

    public SimpleModel getModel() {
        return model;
    }

    public void setModel(SimpleModel model) {
        this.model = notNull(model, "Model can not be null");;
    }

    public SimpleTrim getTrim() {
        return trim;
    }

    public void setTrim(SimpleTrim trim) {
        this.trim = notNull(trim, "Trim can not be null");
    }

    public SimpleYear getYear() {
        return year;
    }

    public void setYear(SimpleYear year) {
        this.year = notNull(year, "Year can not be null");
    }
}
