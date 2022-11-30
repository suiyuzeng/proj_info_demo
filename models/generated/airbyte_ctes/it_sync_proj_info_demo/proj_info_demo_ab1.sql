{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_it_sync_proj_info_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('it_sync_proj_info_demo', '_airbyte_raw_proj_info_demo') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['project'], ['project']) }} as project,
    {{ json_extract_scalar('_airbyte_data', ['pod_count'], ['pod_count']) }} as pod_count,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['deployment_count'], ['deployment_count']) }} as deployment_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('it_sync_proj_info_demo', '_airbyte_raw_proj_info_demo') }} as table_alias
-- proj_info_demo
where 1 = 1

