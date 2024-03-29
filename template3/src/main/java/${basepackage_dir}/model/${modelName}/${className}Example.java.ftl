<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.model.${modelName};

import java.util.Date;

/**
*${table.tableAlias}
*/
public class ${className}Example {
	
    /**
     * ${table.tableAlias}
     */
    protected String orderByClause;

    /**
     * ${table.tableAlias}
     */
    protected boolean distinct;

    /**
     * ${table.tableAlias}
     */
    protected List<Criteria> oredCriteria;

    public DialectInfoExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * ${className} 2019-08-07
     */
    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }
    
        <#list table.columns as column>
        
            public Criteria and${column.columnName}IsNull() {
                addCriterion("${column.columnName} is null");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}IsNotNull() {
                addCriterion("${column.columnName} is not null");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}EqualTo(Long value) {
                addCriterion("${column.columnName} =", value, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}NotEqualTo(Long value) {
                addCriterion("${column.columnName} <>", value, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}GreaterThan(Long value) {
                addCriterion("${column.columnName} >", value, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}GreaterThanOrEqualTo(Long value) {
                addCriterion("${column.columnName} >=", value, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}LessThan(Long value) {
                addCriterion("${column.columnName} <", value, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}LessThanOrEqualTo(Long value) {
                addCriterion("${column.columnName} <=", value, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}In(List<Long> values) {
                addCriterion("${column.columnName} in", values, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}NotIn(List<Long> values) {
                addCriterion("${column.columnName} not in", values, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}Between(Long value1, Long value2) {
                addCriterion("${column.columnName} between", value1, value2, "id");
                return (Criteria) this;
            }
    
            public Criteria and${column.columnName}NotBetween(Long value1, Long value2) {
                addCriterion("${column.columnName} not between", value1, value2, "id");
                return (Criteria) this;
            }
        
        </#list>
       
    }

    /**
     * ${className}
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    /**
     * ${className} 2019-08-07
     */
    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }


