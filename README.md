# Siren

Siren is lightweight web component framework as alternative to Polymer (not 100% replacement). The goal of this project is create a alternative to Polymer and avoid to ShadowDOM.This framework is based on `document.registerElement` method which is not implemented in all browsers now and can be easily [polyfilled](https://github.com/WebReflection/document-register-element).

## Getting Started

For easy start You might put the dependency into your pubspec.yaml:

    dependencies:
        siren: '>=1.0.0 <1.1.0'
        
## How to create component

All you have to do is extend your class as HtmlElement and annotate it with WebComponent.

    @WebComponent("custom-foo")
    class FooElement extends HtmlElement {
      
      FooElement.created() : super.created();
  
      void attached() {
        this.appendHtml("<div>web component FOO</div>");
      }
    }

Then you have to initialize Siren engine which register your new web component under tag you choose.

    void main() {
      initSiren();
    }
    
Last step is use the component. Because Siren is rellying on 'registerElement', you have to include one [polyfill](https://github.com/WebReflection/document-register-element).

    <html>
      <head>
        <!-- 
         You must include this polyfill because not 
         all browsers are supporting registerElement 
        -->    
        <script src="//cdnjs.cloudflare.com/ajax/libs/document-register-element/0.1.2/document-register-element.js"/>
      </head> 
      <body>   
        <!-- custom foo web component -->
        <custom-foo></custom-foo>
            
        <script type="application/dart" src="example.dart"></script>
        <script src="packages/browser/dart.js"></script>
      </body>
    </html>

## How to create template component
The template component is advanced webcomponent which is linked to template in your HTML. This template will be used as a source of HTML for all your instances of components. What you have to do is extending your component as `TemplateComponent` class and fill the ID of template into `WebComponent`.The HTML will be like:

    <html>
      <head>
        <!-- 
         You must include this polyfill because not 
         all browsers are supporting registerElement 
        -->    
        <script src="//cdnjs.cloudflare.com/ajax/libs/document-register-element/0.1.2/document-register-element.js"/>
        
        <template id="custom-template-id">
        	<div> this is template</div>
        </template>
        
      </head> 
      <body>
        <!-- custom template component -->
        <custom-template></custom-template>
            
        <script type="application/dart" src="example.dart"></script>
        <script src="packages/browser/dart.js"></script>
      </body>
    </html>

You template class will be: 

	@WebComponent("custom-template", template: "custom-template-id")
    class CustomTemplate extends TemplateComponent {      
      FooElement.created() : super.created();  
    }
    
**Note:**  If you want to override attached, don't forget call the `super.attached()`.
    
     

## License

Copyright (C) 2014 Zdenko Vrabel Licensed under the Apache License, Version 2.0