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
 * 'WebComponent' annotation the engine will search
 */
class WebComponent {
  
  /// a tag name the component will be available
  final String tag;
  
  /// name of static initialization method
  final String initMethod;
  
  /// ID of template
  final String template;
  
  /**
   * constructor
   */
  const WebComponent(this.tag, {this.initMethod: "", this.template: ""});
  
  
  /**
   * method look for annotation in class mirror
   */
  static WebComponent findAnnotation(ClassMirror mirror) {
    for (var m in mirror.metadata) {
      if (m.reflectee is WebComponent) {
        return m.reflectee;
      }
    }
    return null;
  }
  
  /**
   * metho look for annotation in instance
   */
  static WebComponent findAnnotationInInstance(Object instance) {
    return findAnnotation(reflect(instance).type);
  }
  
  /**
   * method look for annotation in class
   */
  static WebComponent findAnnotationInClass(Type clazz) {
    return findAnnotation(reflectClass(clazz));
  }

}

