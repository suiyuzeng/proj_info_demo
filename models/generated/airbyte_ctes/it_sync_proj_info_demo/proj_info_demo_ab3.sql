{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_it_sync_proj_info_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('proj_info_demo_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'project',
        'pod_count',
        'created_at',
        'deployment_count',
    ]) }} as _airbyte_proj_info_demo_hashid,
    tmp.*
from {{ ref('proj_info_demo_ab2') }} tmp
-- proj_info_demo
where 1 = 1

