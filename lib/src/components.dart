// Copyright 2014 Zdenko Vrabel. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
part of siren;


/**
 * main class representing application and root is acting
 * as <body>.
 */
abstract class SirenApp extends DomManipulationMixin {

  @override
  HtmlElement get root => document.body;  

  /**
   * here you will implement your application
   * initialization code. This method is called
   * before the siren register components
   */
  void init(){    
  }

  /**
   * here you will implement your code
   * after siren is ready.
   */
  void ready();
}


/**
 * basic siren component
 */
abstract class SirenComponent extends HtmlElement with DomManipulationMixin, EventMixin {
  
  /**
   * Constructor
   */
  SirenComponent.created() : super.created();
  
  @override
  HtmlElement get root => this;  
  
  /**
   * do not override this method because templating 
   * will stop working. Use 'ready' instead of this method
   */
  @override
  attached() {
    subscribeEvents();
    ready();
  }
  
  
  /**
   * Here you will implement your initialization 
   * code.
   */
  void ready();
}



/**
 * basic template component
 */
abstract class SirenTemplateComponent extends HtmlElement with DomManipulationMixin, EventMixin {
  
  /// this flag preventing to duplicated templates
  bool _templateAttached = false;
  
  @override
  HtmlElement get root => this;  
  
  /**
   * Constructor
   */
  SirenTemplateComponent.created() : super.created();

  
  /**
   * do not override this method because templating 
   * will stop working. Use 'ready' instead of this method
   */
  @override
  attached() {
    if (!_templateAttached) {
      var webComponentDescriptor = WebComponent.findAnnotationInInstance(this);    
      Element template = templates.templateFor(webComponentDescriptor.template);
      if (template == null) {
        throw new StateError("no template '${webComponentDescriptor.template}' defined in HTML");
      }
      this.children.clear();
      this.appendHtml(template.innerHtml, validator: sirenNodeValidator);
      _templateAttached = true;
      this.subscribeEvents();
          
      ready();
    }
  }

  
  /**
   * Here you will implement your initialization 
   * code.
   */
  void ready();
}