/* AA : candidate operations : gptorre query : prod */ 
SELECT 
	g_p_t_prompt_sessions.id,
	g_p_t_prompt_sessions.task_id,
	g_p_t_prompt_sessions.gpt_prompt_content_id as prompt_version,
	if(g_p_t_prompt_contents.is_production_mode, "PROD", "TEST") as prompt_mode,
	g_p_t_prompt_sessions.created,
	g_p_t_prompt_sessions.status,
	operators.operator_gg_id,
	g_p_t_prompt_sessions.session_output ->> "$.lang" as detected_lang,
	if (g_p_t_prompt_sessions.session_output ->> "$.status" is null, g_p_t_prompt_sessions.session_output ->> "$.state", g_p_t_prompt_sessions.session_output ->> "$.status") as detected_state,
	g_p_t_prompt_sessions.session_output ->> "$.cases" as detected_cases,
	g_p_t_prompt_sessions.executed_prompt_actions as executed_actions,
	g_p_t_prompt_sessions.completed,
	timestampdiff(second, g_p_t_prompt_sessions.created, g_p_t_prompt_sessions.completed) as seconds_spent,
	(((g_p_t_prompt_sessions.session_output ->> "$.promptTokenUsage.promptTokens" * 0.03) / 1000) + ((g_p_t_prompt_sessions.session_output ->> "$.promptTokenUsage.completionTokens" * 0.06) / 1000)) as total_token_cost,
	((g_p_t_prompt_sessions.session_output ->> "$.promptTokenUsage.promptTokens" * 0.03) / 1000) as prompt_token_cost,
	((g_p_t_prompt_sessions.session_output ->> "$.promptTokenUsage.completionTokens" * 0.06) / 1000) as completion_token_cost,
	g_p_t_prompt_sessions.session_output ->> "$.promptTokenUsage.promptTokens" as prompt_token_used,
	g_p_t_prompt_sessions.session_output ->> "$.promptTokenUsage.completionTokens" as completion_token_used
-- 	g_p_t_prompt_sessions.session_input
FROM
    g_p_t_prompt_sessions
    LEFT JOIN g_p_t_prompt_contents ON g_p_t_prompt_contents.id = g_p_t_prompt_sessions.gpt_prompt_content_id
    LEFT JOIN operators ON g_p_t_prompt_sessions.reviewer_id = operators.id
WHERE
    g_p_t_prompt_sessions.id > 28
    AND g_p_t_prompt_contents.is_production_mode = true
ORDER BY g_p_t_prompt_sessions.id desc
