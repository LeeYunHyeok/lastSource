package com.org.iopts.dto;

public class Pi_AgentVO {
	private String target_id;			// 타겟 아이디
	private String agent_id;			// 에이전트 아이디
	private String agent_name;			// 호스트 이름	-- 타겟과 비교 해서 타겟 아이디를 찾음
	private String agent_type;			// 
	private String agent_version;		// 에이전트 버전
	private String agent_platform;		// 플랫폼 (ex : Microsoft Windows 10 Professional 64-bit)
	private String agent_platform_compatibility;		// 플랫폼 (ex : Windows 10 64bit)
	private boolean agent_verified;		// 확인 여부
	private boolean agent_connected;	// 연결 상태 (connected, Not connected)
	private String agent_proxy;			// 프록시
	private String agent_user;			// 사용자
	private String agent_cpu;			// cpu
	private String agent_cores;			// cpu 코어수
	private String agent_boot;			// 부팅
	private String agent_ram;			// ram 크기
	private String agent_started;		// 에이전트가 켜진 시간
	private String agent_connected_ip;	// 연결된 아이피
	public String getTarget_id() {
		return target_id;
	}
	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}
	public String getAgent_id() {
		return agent_id;
	}
	public void setAgent_id(String agent_id) {
		this.agent_id = agent_id;
	}
	public String getAgent_name() {
		return agent_name;
	}
	public void setAgent_name(String agent_name) {
		this.agent_name = agent_name;
	}
	public String getAgent_type() {
		return agent_type;
	}
	public void setAgent_type(String agent_type) {
		this.agent_type = agent_type;
	}
	public String getAgent_version() {
		return agent_version;
	}
	public void setAgent_version(String agent_version) {
		this.agent_version = agent_version;
	}
	public String getAgent_platform() {
		return agent_platform;
	}
	public void setAgent_platform(String agent_platform) {
		this.agent_platform = agent_platform;
	}
	public String getAgent_platform_compatibility() {
		return agent_platform_compatibility;
	}
	public void setAgent_platform_compatibility(String agent_platform_compatibility) {
		this.agent_platform_compatibility = agent_platform_compatibility;
	}
	public boolean isAgent_verified() {
		return agent_verified;
	}
	public void setAgent_verified(boolean agent_verified) {
		this.agent_verified = agent_verified;
	}
	public boolean isAgent_connected() {
		return agent_connected;
	}
	public void setAgent_connected(boolean agent_connected) {
		this.agent_connected = agent_connected;
	}
	public String getAgent_proxy() {
		return agent_proxy;
	}
	public void setAgent_proxy(String agent_proxy) {
		this.agent_proxy = agent_proxy;
	}
	public String getAgent_user() {
		return agent_user;
	}
	public void setAgent_user(String agent_user) {
		this.agent_user = agent_user;
	}
	public String getAgent_cpu() {
		return agent_cpu;
	}
	public void setAgent_cpu(String agent_cpu) {
		this.agent_cpu = agent_cpu;
	}
	public String getAgent_cores() {
		return agent_cores;
	}
	public void setAgent_cores(String agent_cores) {
		this.agent_cores = agent_cores;
	}
	public String getAgent_boot() {
		return agent_boot;
	}
	public void setAgent_boot(String agent_boot) {
		this.agent_boot = agent_boot;
	}
	public String getAgent_ram() {
		return agent_ram;
	}
	public void setAgent_ram(String agent_ram) {
		this.agent_ram = agent_ram;
	}
	public String getAgent_started() {
		return agent_started;
	}
	public void setAgent_started(String agent_started) {
		this.agent_started = agent_started;
	}
	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}
	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}
	
}
