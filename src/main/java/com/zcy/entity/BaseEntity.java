package com.zcy.entity;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@Accessors(chain = true)
public class BaseEntity {
    private Date createdDate;
    private Integer createdId;
    private Integer createdName;
    private Date updatedDate;
    private Integer updatedId;
    private Integer updatedName;
    private Date startDate;
    private Date endDate;
}
