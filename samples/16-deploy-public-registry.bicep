
// 16-deploy-public-registry.bicep

module helloWorld 'br/public:samples/hello-world:1.0.1' = {
  name: 'helloWorld'
  params: {
    name: 'Global Azure 2022 developers'
  }
}

output greeting string = helloWorld.outputs.greeting
