package com.cars.graphtank.year;

import static org.apache.commons.lang3.Validate.notNull;

import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;

import java.util.List;

/**
 * Created by brendandite on 4/20/17.
 */
public class YearService {

    private YearRepository yearRepo;

    public YearService(YearRepository yearRepo) {
        this.yearRepo = notNull(yearRepo, "Year Repo can not be null");
    }

    public List<Year> findAllYears() {
        Iterable<YearNode> yearNodes = yearRepo.findAll(new Sort("year"));
        return flattenNodes(yearNodes);
    }

    private List<Year> flattenNodes(Iterable<YearNode> yearNodes) {
        notNull(yearNodes, "Year Nodes can not be null");
        List<Year> years = Lists.newArrayList();
        for (YearNode yearNode : yearNodes) {
            years.add(new Year(yearNode));
        }
        return years;
    }
}
