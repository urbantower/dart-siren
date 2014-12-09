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
 * basic siren component
 */
abstract class SirenComponent extends HtmlElement with DomManipulationMixin, EventMixin {
  
  /**
   * Constructor
   */
  SirenComponent.created() : super.created();
  
  
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
      this.appendHtml(template.innerHtml);
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