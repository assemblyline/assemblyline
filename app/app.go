package app

type App struct {
	Name        string        `json:"name"`
	Repo        string        `json:"repo"`
	BuildSteps  []BuildStep   `json:"buildSteps"`
	TestSteps   []TestStep    `json:"testSteps"`
	DeploySteps []CommandStep `json:"deploySteps"`
	Backends    []Backend     `json:"backends"`
	Pods        []Pod         `json:"pods"`
}

type BuildStep struct {
	Type string `json:"type"`
	*CommandStep
}

type TestStep struct {
	*CommandStep
	Backends []string `json:"backends"`
}

type CommandStep struct {
	Commands [][]string `json:"commands"`
}

type Backend struct {
	Name    string `json:"string"`
	Type    string `json:"type"`
	version string `json:"version"`
}

type Pod struct {
	Name       string      `json:"name"`
	Containers []Container `json:"containers"`
	Schedule   string      `json:"schedule"`
}

type Container struct {
	Command   []string  `json:"string"`
	Ports     []Port    `json:"ports"`
	Resources Resources `json:"resources"`
}

type Port struct {
	Name          string    `json:"name"`
	ContainerPort int       `json:"containerPort"`
	ServicePort   int       `json:"servicePort"`
	Resources     Resources `json:"resources"`
}

type Resources struct {
	Requests ResourceSpec `json:"requests"`
	Limits   ResourceSpec `json:"limits"`
}

type ResourceSpec struct {
	Cpu    string `json:"cpu"`
	Memory string `json:"memory"`
}
