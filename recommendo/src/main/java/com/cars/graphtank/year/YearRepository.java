package com.cars.graphtank.year;

import org.springframework.data.neo4j.repository.GraphRepository;

/**
 * Created by brendandite on 4/14/17.
 */
public interface YearRepository extends GraphRepository<YearNode> {
}
