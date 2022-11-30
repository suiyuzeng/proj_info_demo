{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_it_sync_proj_info_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('proj_info_demo_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(project as {{ dbt_utils.type_string() }}(1024)) as project,
    cast(pod_count as {{ dbt_utils.type_bigint() }}) as pod_count,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(deployment_count as {{ dbt_utils.type_bigint() }}) as deployment_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('proj_info_demo_ab1') }}
-- proj_info_demo
where 1 = 1

