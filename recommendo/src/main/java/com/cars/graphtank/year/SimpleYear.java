package com.cars.graphtank.year;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/21/17.
 */
public class SimpleYear {

    private Long yearId;

    private Integer year;

    SimpleYear() {}

    public SimpleYear(Long yearId, Integer year) {
        this.yearId = notNull(yearId, "Year Id can not be null");
        this.year = notNull(year, "Year can not be null");
    }

    public SimpleYear(YearNode yearNode) {
        notNull(yearNode, "Year node can not be null");
        this.yearId = yearNode.getYearId();
        this.year = yearNode.getYear();
    }

    public Long getYearId() {
        return yearId;
    }

    public void setYearId(Long yearId) {
        this.yearId = notNull(yearId, "Year Id can not be null");
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = notNull(year, "Year can not be null");
    }
}
