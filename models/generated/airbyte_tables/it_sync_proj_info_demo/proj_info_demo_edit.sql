{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "it_sync_proj_info_demo",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='proj_info_demo_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('proj_info_demo_ab3') }}
select
    id,
    project,
    pod_count,
    deployment_count,
    STR_TO_DATE(created_at,'%Y-%m-%dT%H:%i:%s.000000Z') as created_at
from {{ ref('proj_info_demo_ab3') }}
-- proj_info_demo from {{ source('it_sync_proj_info_demo', '_airbyte_raw_proj_info_demo') }}
where 1 = 1

