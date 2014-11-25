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
 * main engine class
 */
class SirenEngine {
  
  static final Logger _log = new Logger('siren.engine');
  
  /// collection of libraries that will be exluded from scanning process
  List<String> excludedLibraries = new List();
  
  /// collection of libraries that will be exluded from scanning process
  List<String> excludedClasses = new List();

  
  /**
   * Constructor
   */
  SirenEngine() {
    excludedLibraries.add("dart.");
  }
  
  
  /**
   * method goes thourgh libraries and scanning them
   */
  void scan() {
    //go trhough libraries
    var mirrorSystem = currentMirrorSystem();
    for (var library in mirrorSystem.libraries.values) {
      String libraryName = library.qualifiedName.toString().substring("Symbol(\"".length);
      if(_libraryIsNotExcluded(libraryName)) {        
        //go through classes
        for (var declaration in library.declarations.values) {
          if (declaration is ClassMirror) {
            String className = declaration.qualifiedName.toString().substring("Symbol(\"".length);
            if (_classIsNotExcluded(className)) {
              _registerClass(declaration);
            }
          }
        }
      }      
    }    
  }
  
  
  /**
   * method scan the class
   */
  void _registerClass(ClassMirror classMirror) {
    var webComponentDescriptor = _getWebComponentMetadata(classMirror);
    if (webComponentDescriptor != null) {               
      _beforeRegistration(classMirror, webComponentDescriptor);
      document.registerElement(webComponentDescriptor.tag, classMirror.reflectedType);
      _log.fine("registered <${webComponentDescriptor.tag}> as ${classMirror.qualifiedName}");
    }
  }
  
  
  /**
   * method call static method marked as initialization
   * method in WebComponent descriptor
   */
  _beforeRegistration(ClassMirror classMirror, WebComponent descriptor) {
    if (descriptor.initMethod.isNotEmpty) {
      classMirror.invoke(new Symbol(descriptor.initMethod), []);
    }
  }
  
  
  /**
   * method returns web component metadata (if they're available)
   */
  WebComponent _getWebComponentMetadata(ClassMirror mirror) {
    for (var m in mirror.metadata) {
      if (m.reflectee is WebComponent) {
        return m.reflectee;
      }
    }
    return null;
  }
  
  
  /**
   * method checking whether library is not excluded
   */
  bool _libraryIsNotExcluded(String libraryName) {
    for (var exclPrefix in excludedLibraries) {
      if (libraryName.startsWith(exclPrefix)) {
        return false;
      }
    }
    return true;
  }
  

  /**
   * method checking whether class is not excluded
   */
  bool _classIsNotExcluded(String className) {
    for (var exclPrefix in excludedClasses) {
      if (className.startsWith(exclPrefix)) {
        return false;
      }
    }
    return true;    
  }
}