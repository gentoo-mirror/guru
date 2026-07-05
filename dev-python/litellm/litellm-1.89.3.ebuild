# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Lightweight package to seamlessly call OpenAI, Azure, Cohere, Anthropic, etc."
HOMEPAGE="
	https://github.com/BerriAI/litellm
	https://pypi.org/project/litellm/
"
SRC_URI="https://github.com/BerriAI/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64" # ~arm64: fastapi, tokenizers

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/aiohttp-3.10.0[${PYTHON_USEDEP}]
		>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/fastuuid-0.14.0[${PYTHON_USEDEP}]
		>=dev-python/httpx-0.28.0[${PYTHON_USEDEP}]
		>=dev-python/importlib-metadata-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/openai-2.20.0[${PYTHON_USEDEP}]
		>=dev-python/pydantic-2.10.0[${PYTHON_USEDEP}]
		>=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/tiktoken-0.8.0[${PYTHON_USEDEP}]
	')
	>=sci-ml/tokenizers-0.21.0[${PYTHON_SINGLE_USEDEP}]
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			>=dev-python/apscheduler-3.11.2[${PYTHON_USEDEP}]
			>=dev-python/backoff-2.2.1[${PYTHON_USEDEP}]
			>=dev-python/boto3-1.43.1[${PYTHON_USEDEP}]
			>=dev-python/fakeredis-2.34.1[${PYTHON_USEDEP}]
			>=dev-python/fastapi-0.136.3[${PYTHON_USEDEP}]
			>=dev-python/fastapi-sso-0.19.0[${PYTHON_USEDEP}]
			dev-python/google-auth[${PYTHON_USEDEP}]
			>=dev-python/mcp-1.26.0[${PYTHON_USEDEP}]
			>=dev-python/openapi-core-0.22.0[${PYTHON_USEDEP}]
			>=dev-python/opentelemetry-api-1.28.0[${PYTHON_USEDEP}]
			>=dev-python/opentelemetry-exporter-otlp-proto-grpc-1.28.0[${PYTHON_USEDEP}]
			>=dev-python/opentelemetry-exporter-otlp-proto-http-1.28.0[${PYTHON_USEDEP}]
			>=dev-python/opentelemetry-sdk-1.28.0[${PYTHON_USEDEP}]
			>=dev-python/orjson-3.11.6[${PYTHON_USEDEP}]
			>=dev-python/parameterized-0.9.0[${PYTHON_USEDEP}]
			>=dev-python/prometheus-client-0.20.0[${PYTHON_USEDEP}]
			>=dev-python/pydantic-settings-2.14.1[${PYTHON_USEDEP}]
			>=dev-python/soundfile-0.12.1[${PYTHON_USEDEP}]
			>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
		')
	)
"

EPYTEST_PLUGINS=( pytest-{asyncio,mock,recording} respx )
EPYTEST_RERUNS=10
EPYTEST_XDIST=1
distutils_enable_tests pytest

python_test() {
	local -x PATH=${BUILD_DIR}/test/usr/bin:${PATH}
	cp -a "${BUILD_DIR}"/{install,test} || die

	local EPYTEST_IGNORE=(
		# missing various packages for the optional proxy function
		# see below
		tests/test_litellm/proxy/

		# a2a
		tests/test_litellm/a2a_protocol/
		tests/test_litellm/llms/langflow/test_langflow_a2a.py

		# azure-identity
		tests/test_litellm/caching/test_azure_blob_cache.py
		tests/test_litellm/secret_managers/test_get_azure_ad_token_provider.py
		tests/test_litellm/llms/azure/test_azure_common_utils.py

		# fastapi-offline
		# tests/test_litellm/proxy/test_fastapi_offline_routes.py

		# polars
		tests/test_litellm/integrations/cloudzero/test_cloudzero.py
		tests/test_litellm/integrations/cloudzero/test_cloudzero_database.py
		tests/test_litellm/integrations/cloudzero/test_cz_stream_api.py
		tests/test_litellm/integrations/cloudzero/test_dry_run_endpoint.py
		tests/test_litellm/integrations/cloudzero/test_transform.py
		tests/test_litellm/integrations/focus/test_csv_serializer.py
		tests/test_litellm/integrations/focus/test_focus_database.py
		tests/test_litellm/integrations/focus/test_focus_transformer.py

		# prisma
		# tests/test_litellm/proxy/auth/test_auth_exception_handler.py
		# tests/test_litellm/proxy/db/test_exception_handler.py
		# tests/test_litellm/proxy/db/test_exception_handler_reconnect_retry.py
		# tests/test_litellm/proxy/health_endpoints/test_health_endpoints.py
		# tests/test_litellm/proxy/management_endpoints/test_access_group_endpoints.py
		# tests/test_litellm/proxy/management_endpoints/test_config_override_endpoints.py
		# tests/test_litellm/proxy/management_endpoints/test_workflow_management_endpoints.py

		# RestrictedPython
		# tests/test_litellm/proxy/guardrails/guardrail_hooks/test_response_rejection_guardrail_code.py
		# tests/test_litellm/proxy/guardrails/test_custom_code_security.py
		# tests/test_litellm/proxy/guardrails/test_guardrail_endpoints.py
		# tests/test_litellm/proxy/management_endpoints/policy_endpoints/test_ai_policy_suggester.py
		# tests/test_litellm/proxy/management_endpoints/policy_endpoints/test_endpoints.py
		# tests/test_litellm/proxy/management_endpoints/test_policy_endpoints.py
		# tests/test_litellm/proxy/policy_engine/test_pipeline_executor.py

		# network
		tests/test_litellm/llms/volcengine/test_volcengine_embedding.py

		# fail because inspect.getfullargspec(redis.Redis) isn't returning the
		# constructor args (Redis.__init__ is a wrapped function)
		# Fix: https://github.com/BerriAI/litellm/pull/30644
		tests/test_litellm/caching/test_redis_cache.py
		tests/test_litellm/caching/test_redis_connection_pool.py
		tests/test_litellm/test_redis.py
	)

	local EPYTEST_DESELECT=(
		# proxy
		tests/test_litellm/integrations/arize/test_arize_otel_coexistence.py::TestProxyLoggerNotOverwritten::test_arize_does_not_set_proxy_otel_logger
		tests/test_litellm/integrations/arize/test_arize_otel_coexistence.py::TestProxyLoggerNotOverwritten::test_arize_phoenix_does_not_set_proxy_otel_logger
		tests/test_litellm/passthrough/test_passthrough_main.py::test_pass_through_request_stream_param_no_override
		tests/test_litellm/passthrough/test_passthrough_main.py::test_pass_through_request_stream_param_override
		tests/test_litellm/llms/anthropic/chat/guardrail_translation/test_anthropic_guardrail_handler.py::TestAnthropicMessagesHandlerInputProcessing::test_process_input_messages_preserves_litellm_metadata_guardrails

		# azure-identity
		tests/test_litellm/secret_managers/test_secret_managers_main.py::test_oidc_azure_ad_token_succes

		# google-cloud-aiplatform
		tests/test_litellm/litellm_core_utils/test_streaming_handler.py::test_gemini_legacy_vertex_stop_finish_reason_normalised
		tests/test_litellm/litellm_core_utils/test_streaming_handler.py::test_gemini_legacy_vertex_tool_calls_finish_reason_with_stop_enum
		tests/test_litellm/llms/gemini/test_gemini_common_utils.py::TestGoogleAIStudioTokenCounter::test_clean_contents_for_gemini_api_preserves_other_fields
		tests/test_litellm/llms/gemini/test_gemini_common_utils.py::TestGoogleAIStudioTokenCounter::test_clean_contents_for_gemini_api_removes_id_field
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_basic_request
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_error_handling
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_fake_streaming
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_filters_context_management
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_filters_stream_and_stream_options

		# langfuse
		tests/test_litellm/enterprise/enterprise_callbacks/test_callback_controls.py::TestEnterpriseCallbackControls::test_callback_disabled_langfuse_customlogger

		# network (broken mock?)
		tests/test_litellm/llms/custom_httpx/test_credential_leak_prevention.py::TestHTTPHandlerErrorPaths::test_async_raises_masked_error
		tests/test_litellm/test_dashscope_image_generation.py::test_litellm_image_generation_dashscope_end_to_end

		# flaky (async issues)
		tests/test_litellm/caching/test_s3_cache.py::test_s3_cache_concurrent_async_operations
	)

	# Covered by the BerriAI Enterprise license
	# Our "non-production-use" is implicitly allowed
	# https://github.com/BerriAI/litellm/blob/v1.89.3/enterprise/LICENSE.md
	pushd enterprise >/dev/null || die
	distutils_pep517_install "${BUILD_DIR}"/test
	popd >/dev/null || die

	epytest tests/test_litellm
}
