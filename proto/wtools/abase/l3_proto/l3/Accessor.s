( function _Accessor_s_() {

'use strict';

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;
let _nameFielded = _.nameFielded;

_.assert( _.objectIs( _.field ), 'wProto needs wTools/staging/wtools/abase/l1/FieldMapper.s' );
_.assert( _.routineIs( _nameFielded ), 'wProto needs wTools/staging/wtools/l3/NameTools.s' );

/**
 * @summary Collection of cross-platform routines for declaring accessors
 * @namespace wTools.accessor
 * @extends Tools
 * @module Tools/base/Proto
 */

/**
 * @summary Collection of getters
 * @namespace wTools.accessor.getter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

 /**
 * @summary Collection of setters
 * @namespace wTools.accessor.setter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

 /**
 * @summary Collection of putters
 * @namespace wTools.accessor.putter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

/**
 * @summary Collection of setters
 * @namespace wTools.accessor.suite
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

// --
// fields
// --

/**
 * Accessor defaults
 * @typedef {Object} AccessorDefaults
 * @property {Boolean} [ strict=1 ]
 * @property {Boolean} [ preservingValue=1 ]
 * @property {Boolean} [ prime=1 ]
 * @property {String} [ combining=null ]
 * @property {Boolean} [ readOnly=0 ]
 * @property {Boolean} [ readOnlyProduct=0 ]
 * @property {Boolean} [ enumerable=1 ]
 * @property {Boolean} [ configurable=0 ]
 * @property {Function} [ getter=null ]
 * @property {Function} [ taker=null ]
 * @property {Function} [ setter=null ]
 * @property {Function} [ suite=null ]
 * @namespace Tools.accessor
 **/


let AccessorType = [ 'take', 'get', 'put', 'set', 'copy' ];
let AccessorTypeMap =
{
  take : null,
  get : null,
  put : null,
  set : null,
  copy : null,
  suite : null,
}
let Combining = [ 'rewrite', 'supplement', 'apppend', 'prepend' ];

let AccessorDefaults =
{

  ... AccessorTypeMap,
  suite : null,

  strict : 1,
  preservingValue : null,
  prime : null,
  combining : null,
  addingMethods : null,
  enumerable : null,
  configurable : null,

  readOnly : 0,
  readOnlyProduct : 0,

}

let AccessorPreferences =
{

  ... AccessorTypeMap,
  suite : null,

  strict : 1,
  preservingValue : 1,
  prime : null,
  combining : null,
  addingMethods : 0,
  enumerable : 1,
  configurable : 0,

  readOnly : 0,
  readOnlyProduct : 0,

}

// --
// getter / setter generator
// --

function _propertyGetterSetterNames( propertyName )
{
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( propertyName ) );

  result.take = '_' + propertyName + 'Take';
  result.get = '_' + propertyName + 'Get';
  result.put = '_' + propertyName + 'Put';
  result.set = '_' + propertyName + 'Set';
  result.copy = '_' + propertyName + 'Copy';

  /* xxx : use it more extensively */

  return result;
}

//

function _optionsNormalize( o )
{

  _.assert( arguments.length === 1 );

  optionNormalize( 'take', 'get' );
  optionNormalize( 'get', 'take' );
  optionNormalize( 'put' );
  optionNormalize( 'set', 'put' );

  // // debugger;
  // // _.assert( _.boolIs( o.take ) || _.routineIs( o.take ) );
  // // _.assert( _.boolIs( o.get ) || _.routineIs( o.get ) );
  // // _.assert( _.boolIs( o.put ) || _.routineIs( o.put ) );
  // // _.assert( _.boolIs( o.set ) || _.routineIs( o.set ) );

  function optionNormalize( n1, n2 )
  {
    // if( o[ n1 ] === null )
    // {
    //   if( o.suite && o.suite[ n1 ] !== undefined && o.suite[ n1 ] !== null )
    //   o[ n1 ] = o.suite[ n1 ];
    //   else if( n2 && o[ n2 ] !== null )
    //   o[ n1 ] = !!o[ n2 ];
    // }
    if( _.boolLike( o[ n1 ] ) )
    o[ n1 ] = !!o[ n1 ];
  }

}

//

function _methodsMake( o )
{
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.objectLikeOrRoutine( o.methods ) );
  _.assert( _.strIs( o.name ) || _.symbolIs( o.name ) );
  _.assert( !!o.object );
  _.assertRoutineOptions( _methodsMake, o );

  if( o.suite )
  {
    _.assertMapHasOnly( o.suite, _.accessor.AccessorType );
  }

  let fieldName;
  let fieldSymbol;
  if( _.symbolIs( o.name ) )
  {
    fieldName = Symbol.keyFor( o.name );
    fieldSymbol = o.name;
  }
  else
  {
    fieldName = o.name;
    fieldSymbol = Symbol.for( o.name );
  }

  if( _global_.debugger )
  debugger;

  methodsNormalize( 'take' );
  methodsNormalize( 'get' );
  methodsNormalize( 'put' );
  methodsNormalize( 'set' );
  methodsNormalize( 'copy' );

  /* take */

  if( !result.take || result.take === true )
  if( o.take === null || o.take === true || o.take === 1 )
  {
    let copy = result.copy;
    if( copy )
    result.take = function take()
    {
      let it = _.accessor.copyIterationMake
      ({
        srcInstance : this,
        instanceKey : fieldName,
        accessorKind : 'take',
      });
      copy.call( this, it );
      return it.value;
    }
    else if( _.routineIs( result.get ) )
    result.take = result.get;
    else
    result.take = function take()
    {
      return this[ fieldSymbol ];
    }
  }

  /* get */

  if( !result.get || result.get === true )
  if( o.get === null || o.get === true || o.get === 1 )
  {
    let copy = result.copy;
    if( copy )
    result.get = function get()
    {
      let it = _.accessor.copyIterationMake
      ({
        srcInstance : this,
        instanceKey : fieldName,
        accessorKind : 'get',
      });
      copy.call( this, it );
      return it.value;
    }
    else if( _.routineIs( result.take ) )
    result.get = result.take;
    else
    result.get = function get()
    {
      return this[ fieldSymbol ];
    }
  }

  /* put */

  if( !result.put || result.put === true )
  if( o.put === null || o.put === true || o.put === 1 )
  {
    let copy = result.copy;
    if( copy )
    result.put = function put( src )
    {
      let it = _.accessor.copyIterationMake
      ({
        dstInstance : this,
        instanceKey : fieldName,
        value : src,
        accessorKind : 'put',
      });
      copy.call( this, it );
      return it.value;
    }
    else if( _.routineIs( result.set ) )
    result.put = result.set;
    else
    result.put = function put( src )
    {
      this[ fieldSymbol ] = src;
      return src;
    }
  }

  /* set */

  if( !result.set || result.set === true )
  if( o.set === null || o.set === true || o.set === 1 )
  {
    let copy = result.copy;
    if( copy )
    result.set = function set( src )
    {
      let it = _.accessor.copyIterationMake
      ({
        dstInstance : this,
        instanceKey : fieldName,
        value : src,
        accessorKind : 'set',
      });
      copy.call( this, it );
      return it.value;
    }
    else if( _.routineIs( result.put ) )
    result.set = result.put;
    // else
    else if( o.put !== false || o.set ) /* yyy xxx : similar logic for other accessors? */
    result.set = function set( src )
    {
      this[ fieldSymbol ] = src;
      return src;
    }
    else
    o.set = false;
  }

  /* readOnlyProduct */

  if( o.readOnlyProduct && result.get )
  {
    let get = result.get;
    result.get = function get()
    {
      debugger;
      let result = get.apply( this, arguments );
      if( !_.primitiveIs( result ) )
      result = _.proxyReadOnly( result );
      return result;
    }
  }

  /* validation */

  _.assert
  (
    !result.take || o.take !== false,
    () => `Field "${fieldName}" is read only, but taker found in ${_.toStrShort( o.methods )}`
  );
  _.assert
  (
    !result.get || o.get !== false,
    () => `Field "${fieldName}" is read only, but getter found in ${_.toStrShort( o.methods )}`
  );
  _.assert
  (
    !result.put || o.put !== false,
    () => `Field "${fieldName}" is read only, but putter found in ${_.toStrShort( o.methods )}`
  );
  _.assert
  (
    !result.set || o.set !== false,
    () => `Field "${fieldName}" is read only, but setter found in ${_.toStrShort( o.methods )}`
  );

  _.assert
  (
    !!result.set || o.set === false,
    () => `Field "${fieldName}" is not read only, but setter not found in ${_.toStrShort( o.methods )}`
  );
  _.assert
  (
    !!result.get || o.get === false,
    () => `Field "${fieldName}" is not read only, but getter not found in ${_.toStrShort( o.methods )}`
  );
  _.assert
  (
    !!result.take || o.take === false,
    () => `Field "${fieldName}" is not read only, but taker not found in ${_.toStrShort( o.methods )}`
  );
  _.assert
  (
    !!result.put || !o.put,
    () => `Field "${fieldName}" putter not found in ${_.toStrShort( o.methods )}`
  );

  _.assert
  (
    result.take === undefined || _.routineIs( result.take ),
    () =>  `Expects routine, but take-accessor of field "${fieldName}" is ${_.toStrShort( o.take )}`
  );
  _.assert
  (
    result.get === undefined || _.routineIs( result.get ) || _.definitionIs( result.get ),
    () =>  `Expects routine, but get-accessor of field "${fieldName}" is ${_.toStrShort( o.get )}`
  );
  _.assert
  (
    result.put === undefined || _.routineIs( result.put ),
    () =>  `Expects routine, but put-accessor of field "${fieldName}" is ${_.toStrShort( o.put )}`
  );
  _.assert
  (
    result.set === undefined || _.routineIs( result.set ),
    () =>  `Expects routine, but set-accessor of field "${fieldName}" is ${_.toStrShort( o.set )}`
  );

  return result;

  /* */

  function methodsNormalize( name )
  {
    let capitalName = _.strCapitalize( name );
    _.assert( o[ name ] === null || _.boolLike( o[ name ] ) || _.routineIs( o[ name ] ) || _.definitionIs( o[ name ] ) );
    if( o[ name ] !== false && o[ name ] !== 0 )
    {
      if( _.routineIs( o[ name ] ) || _.definitionIs( o[ name ] ) )
      result[ name ] = o[ name ];
      else if( o.suite && ( _.routineIs( o.suite[ name ] ) || _.definitionIs( o.suite[ name ] ) ) )
      result[ name ] = o.suite[ name ];
      else if( o.methods[ '' + fieldName + capitalName ] )
      result[ name ] = o.methods[ fieldName + capitalName ];
      else if( o.methods[ '_' + fieldName + capitalName ] )
      result[ name ] = o.methods[ '_' + fieldName + capitalName ];
    }
  }

  /* */

}

_methodsMake.defaults =
{
  ... AccessorTypeMap,
  suite : null,

  name : null,
  object : null,
  methods : null,
  readOnlyProduct : 0, /* xxx : remove? */
}

//

function _methodsUnfunct( o )
{

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o.amethods ) );
  _.assertRoutineOptions( _methodsUnfunct, arguments );

  resultUnfunct( 'take' );
  resultUnfunct( 'get' );
  resultUnfunct( 'put' );
  resultUnfunct( 'set' );
  resultUnfunct( 'copy' );

  return o.amethods;

  /* */

  function resultUnfunct( kind )
  {
    _.assert( _.primitiveIs( kind ) );
    if( !o.amethods[ kind ] )
    return;
    let amethod = o.amethods[ kind ];
    let r = _.accessor._methodUnfunct({ amethod, kind, accessor : o });
    o.amethods[ kind ] = r;
    return r;
  }

}

var defaults = _methodsUnfunct.defaults =
{
  ... AccessorDefaults,
  name : null,
  object : null,
  methods : null,
  amethods : null,
}

//

function _methodUnfunct( o )
{

  _.assert( arguments.length === 1 );

  if( !_.routineIs( o.amethod ) )
  return o.amethod;

  if( o.amethod && o.amethod.identity && _.longHas( o.amethod.identity, 'functor' ) )
  {
    let o2 = Object.create( null );
    if( o.amethod.defaults )
    {
      if( o.amethod.defaults.fieldName !== undefined )
      o2.fieldName = o.accessor.name;
      if( o.amethod.defaults.accessor !== undefined )
      o2.accessor = o.accessor;
      if( o.amethod.defaults.accessorKind !== undefined )
      o2.accessorKind = o.kind;
    }
    o.amethod = o.amethod( o2 );
  }

  return o.amethod;
}

_methodUnfunct.defaults =
{
  amethod : null,
  accessor : null,
  kind : null,
}

//

function _methodsNames( o )
{

  _.routineOptions( _methodsNames, o );

  if( o.anames === null )
  o.anames = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o.amethods ) );
  _.assert( _.strIs( o.name ) );
  _.assert( !!o.object );

  for( let t = 0 ; t < _.accessor.AccessorType.length ; t++ ) /* xxx */
  {
    let type = _.accessor.AccessorType[ t ];
    if( o.amethods[ type ] && !o.anames[ type ] )
    {
      let type2 = _.strCapitalize( type );
      if( o.object[ o.name + type2 ] === o.amethods[ type ] )
      o.anames[ type ] = o.name + type2;
      else if( o.object[ '_' + o.name + type2 ] === o.amethods[ type ] )
      o.anames[ type ] = '_' + o.name + type2;
      else
      o.anames[ type ] = o.name + type2;
    }
  }

  return o.anames;
}

_methodsNames.defaults =
{
  object : null,
  amethods : null,
  anames : null,
  name : null,
}

//

function _methodsRetrieve( object, propertyName )
{
  let result = Object.create( null );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectIs( object ) );
  _.assert( _.strIs( propertyName ) );

  result.takeName = object[ propertyName + 'Take' ] ? propertyName + 'Take' : '_' + propertyName + 'Take';
  result.getName = object[ propertyName + 'Get' ] ? propertyName + 'Get' : '_' + propertyName + 'Get';
  result.putName = object[ propertyName + 'Put' ] ? propertyName + 'Put' : '_' + propertyName + 'Put';
  result.setName = object[ propertyName + 'Set' ] ? propertyName + 'Set' : '_' + propertyName + 'Set';
  result.copyName = object[ propertyName + 'Copy' ] ? propertyName + 'Copy' : '_' + propertyName + 'Copy';

  result.take = object[ result.takeName ];
  result.get = object[ result.getName ];
  result.set = object[ result.setName ];
  result.copy = object[ result.copyName ];
  result.put = object[ result.putName ];

  return result;
}

//

function _methodsValidate( o )
{

  _.assert( _.strIs( o.name ) || _.symbolIs( o.name ) );
  _.assert( !!o.object );
  _.routineOptions( _methodsValidate, o );

  if( _.symbolIs( o.name ) )
  debugger;

  let name = _.symbolIs( o.name ) ? Symbol.keyFor( o.name ) : o.name;

  // let AccessorType = _.accessor.AccessorType; /* xxx : ? */
  let AccessorType = [ 'get', 'set' ];

  for( let t = 0 ; t < AccessorType.length ; t++ )
  {
    let type = AccessorType[ t ];
    if( !o.amethods[ type ] )
    {
      let name1 = name + _.strCapitalize( type );
      let name2 = '_' + name + _.strCapitalize( type );
      if( name1 in o.object )
      throw _.err( `Object should not have method ${name1}, if accessor has it disabled` );
      if( name2 in o.object )
      throw _.err( `Object should not have method ${name2}, if accessor has it disabled` );
    }
  }

}

_methodsValidate.defaults =
{
  object : null,
  amethods : null,
  name : null,
}

//

function _methodCopyGet( srcInstance, name )
{
  _.assert( arguments.length === 2 );
  _.assert( _.strIs( name ) );

  if( !_.instanceIs( srcInstance ) )
  return null;

  if( srcInstance[ '' + name + 'Copy' ] )
  return srcInstance[ name + 'Copy' ];
  else if( srcInstance[ '_' + name + 'Copy' ] )
  return srcInstance[ '_' + name + 'Copy' ];

  return null;
}

//

function copyIterationMake( o )
{
  return _.routineOptions( copyIterationMake, arguments );
}

copyIterationMake.defaults =
{
  dstInstance : null,
  srcInstance : null,
  instanceKey : null,
  srcContainer : null,
  dstContainer : null,
  containerKey : null,
  accessorKind : null,
  value : null,
}

// --
// declare
// --

/**
 * Registers provided accessor.
 * Writes accessor's descriptor into accessors map of the prototype ( o.proto ).
 * Supports several combining methods: `rewrite`, `supplement`, `append`.
 *  * Adds diagnostic information to descriptor if running in debug mode.
 * @param {Object} o - options map
 * @param {String} o.name - accessor's name
 * @param {Object} o.proto - target prototype object
 * @param {String} o.declaratorName
 * @param {Array} o.declaratorArgs
 * @param {String} o.declaratorKind
 * @param {String} o.combining - combining method
 * @private
 * @function _register
 * @namespace Tools.accessor
 */

function _register( o )
{

  _.routineOptions( _register, arguments );
  _.assert( _.prototypeIsStandard( o.proto ), 'Expects formal prototype' );
  _.assert( _.strDefined( o.declaratorName ) );
  _.assert( _.arrayIs( o.declaratorArgs ) );
  _.workpiece.fieldsGroupFor( o.proto, '_Accessors' );

  let accessors = o.proto._Accessors;

  if( o.combining && o.combining !== 'rewrite' && o.combining !== 'supplement' )
  debugger;

  if( Config.debug )
  if( !o.combining )
  {
    let stack = accessors[ o.name ] ? accessors[ o.name ].stack : '';
    _.assert
    (
      !accessors[ o.name ],
      'defined at' + '\n',
      stack,
      '\naccessor', o.name, 'of', o.proto.constructor.name
    );
    if( accessors[ o.name ] )
    debugger;
  }

  _.assert( !o.combining || o.combining === 'rewrite' || o.combining === 'append' || o.combining === 'supplement', 'not supported ( o.combining )', o.combining );
  _.assert( _.strIs( o.name ) );

  if( accessors[ o.name ] && o.combining === 'supplement' )
  return;

  let descriptor =
  {
    name : o.name,
    declaratorName : o.declaratorName,
    declaratorArgs : o.declaratorArgs,
    declaratorKind : o.declaratorKind,
    combining : o.combining,
  }

  if( Config.debug )
  descriptor.stack = _.introspector.stack();

  if( o.combining === 'append' )
  {
    if( _.arrayIs( accessors[ o.name ] ) )
    accessors[ o.name ].push( descriptor );
    else
    accessors[ o.name ] = [ descriptor ];
  }

  accessors[ o.name ] = descriptor;

  return descriptor;
}

_register.defaults =
{
  name : null,
  proto : null,
  declaratorName : null,
  declaratorArgs : null,
  declaratorKind : null,
  combining : 0,
}

//

function _declareAct( o )
{

  _.assertRoutineOptions( _declareAct, arguments );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.name ) || _.symbolIs( o.name ) );
  _.assert( _.longHas( [ null, 0, false, 'rewrite', 'supplement' ], o.combining ), 'not tested' );

  if( _global_.debugger )
  debugger;

  _.accessor._optionsNormalize( o );

  let fieldName;
  let fieldSymbol;
  if( _.symbolIs( o.name ) )
  {
    fieldName = Symbol.keyFor( o.name );
    fieldSymbol = o.name;
  }
  else
  {
    fieldName = o.name;
    fieldSymbol = Symbol.for( o.name );
  }

  /* */

  let propertyDescriptor = _.propertyDescriptorActiveGet( o.object, o.name );
  if( propertyDescriptor.descriptor )
  {

    _.assert
    (
      _.strIs( o.combining ), () =>
      'overriding of property ' + o.name + '\n' +
      '{-o.combining-} suppose to be ' + _.strQuote( _.accessor.Combining ) + ' if accessor overided, ' +
      'but it is ' + _.strQuote( o.combining )
    );

    _.assert( o.combining === 'rewrite' || o.combining === 'append' || o.combining === 'supplement', 'not implemented' );

    if( o.combining === 'supplement' )
    return;

    _.assert( o.combining === 'rewrite', 'not implemented' );
    _.assert( propertyDescriptor.object !== o.object, () => `Attempt to redefine own accessor "${o.name}" of ${_.toStrShort( o.object )}` );

  }

  // if( _global_.debugger )
  // debugger;

  /* */

  o.suite = _.accessor._methodUnfunct
  ({
    amethod : o.suite,
    accessor : o,
    kind : 'suite',
  });

  // if( o.name === 'dims' )
  // debugger;

  o.amethods = _.accessor._methodsMake /* xxx : rename amethods -> suite */
  ({
    name : o.name,
    methods : o.methods,
    object : o.object,
    readOnlyProduct : o.readOnlyProduct,
    take : o.take,
    get : o.get,
    put : o.put,
    set : o.readOnly ? false : o.set,
    copy : o.copy,
    suite : o.suite,
  });

  o.amethods = _.accessor._methodsUnfunct( o );

  defaultsApply();

  let anames;
  if( o.prime || o.addingMethods )
  anames = _.accessor._methodsNames
  ({
    object : o.object,
    amethods : o.amethods,
    name : o.name,
  })

  /* */

  if( o.prime )
  {

    let o2 = _.mapExtend( null, o );
    o2.names = o.name;
    if( o2.methods === o2.object )
    o2.methods = Object.create( null );
    o2.object = null;
    delete o2.name;
    delete o2.amethods;
    for( let k in o.amethods )
    o2.methods[ anames[ k ] ] = o.amethods[ k ];

    _.accessor._register
    ({
      proto : o.object,
      name : o.name,
      declaratorName : 'accessor',
      declaratorArgs : [ o2 ],
      combining : o.combining,
    });

  }

  // let fieldSymbol = _.symbolIs( o.name ) ? o.name : Symbol.for( o.name );

  /* preservingValue */

  if( o.preservingValue )
  if( _ObjectHasOwnProperty.call( o.object, o.name ) )
  {
    if( o.amethods.put )
    o.amethods.put.call( o.object, o.object[ o.name ] );
    else
    o.object[ fieldSymbol ] = o.object[ o.name ];
  }

  /* addingMethods */

  if( o.addingMethods )
  {
    for( let n in o.amethods )
    {
      o.object[ anames[ n ] ] = o.amethods[ n ];
    }
  }

  /* define accessor */

  // _.assert( o.amethods.get !== undefined );
  _.assert( o.amethods.get === undefined || _.routineIs( o.amethods.get ) || _.definitionIs( o.amethods.get ) );
  _.assert( o.amethods.set === undefined || _.routineIs( o.amethods.set ) );

  let o2 =
  {
    enumerable : !!o.enumerable,
    configurable : !!o.configurable,
  }
  if( o.amethods.get === undefined )
  {
    if( o.amethods.set )
    o2.set = o.amethods.set;
  }
  else if( _.routineIs( o.amethods.get ) )
  {
    if( o.amethods.set )
    o2.set = o.amethods.set;
    // else
    // o2.writable = false;
    o2.get = o.amethods.get;
  }
  else
  {
    _.assert( o.amethods.set === undefined );
    if( _.definitionIs( o.amethods.get ) )
    o2.value = o.amethods.get.ini;
    else
    o2.value = o.amethods.get;
  }

  // if( o.name === 'fieldsOfRelationsGroups' )
  // debugger;

  Object.defineProperty( o.object, o.name, o2 );

  // console.log( o.object.fieldsOfRelationsGroups );

  /* validate */

  if( Config.debug )
  _.accessor._methodsValidate({ object : o.object, name : o.name, amethods : o.amethods });

  /* forbid underscore field */

  if( o.strict && !propertyDescriptor.descriptor )
  forbid();

  /* - */

  function forbid()
  {
    let forbiddenName = '_' + fieldName;
    let m =
    [
      'Use Symbol.for( \'' + fieldName + '\' ) ',
      'to get direct access to property value, ',
      'not ' + forbiddenName,
    ].join( '' );

    if( !_.prototypeIsStandard( o.object ) || !_.prototypeHasField( o.object, forbiddenName ) )
    _.accessor.forbid
    ({
      object : o.object,
      names : forbiddenName,
      message : [ m ],
      prime : 0,
      strict : 0,
    });

  }

  /* */

  function defaultsApply()
  {

    if( o.prime === null )
    o.prime = _.prototypeIsStandard( o.object );

    for( let k in o )
    {
      if( o[ k ] === null && _.boolLike( _.accessor.AccessorPreferences[ k ] ) )
      o[ k ] = _.accessor.AccessorPreferences[ k ];
    }

    _.assert( _.boolLike( o.prime ) );
    _.assert( _.boolLike( o.configurable ) );
    _.assert( _.boolLike( o.enumerable ) );
    _.assert( _.boolLike( o.addingMethods ) );
    _.assert( _.boolLike( o.preservingValue ) );

  }

  /* */

}

var defaults = _declareAct.defaults =
{
  ... AccessorDefaults,
  name : null,
  object : null,
  methods : null,
}

//

/**
 * Generates options map for declare.body, _forbidDeclare functions.
 * Can be called in three ways:
 * - First by passing all options in one object;
 * - Second by passing object and name options;
 * - Third by passing object, names and message option as third parameter.
 * @param {Object} o - options {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}.
 *
 * @example
 * //returns
 * // { object: [Function],
 * // methods: [Function],
 * // names: { a: 'a', b: 'b' },
 * // message: [ 'set/get call' ] }
 *
 * let Self = ClassName;
function ClassName( o ) { };
 * _.accessor._declare_head( Self, { a : 'a', b : 'b' }, 'set/get call' );
 *
 * @private
 * @function _declare_head
 * @namespace Tools.accessor
 */

function _declare_head( routine, args )
{
  let o;

  _.assert( arguments.length === 2 );

  if( args.length === 1 )
  {
    o = args[ 0 ];
  }
  else
  {
    o = Object.create( null );
    o.object = args[ 0 ];
    o.names = args[ 1 ];
    _.assert( args.length >= 2 );
  }

  if( args.length > 2 )
  {
    _.assert( o.messages === null || o.messages === undefined );
    o.message = _.longSlice( args, 2 );
  }

  if( _.strIs( o.names ) )
  o.names = { [ o.names ] : o.names }

  _.routineOptions( routine, o );
  _.assert( !_.primitiveIs( o.object ), 'Expects object as argument but got', o.object );
  _.assert( _.objectIs( o.names ) || _.arrayIs( o.names ), 'Expects object names as argument but got', o.names );

  return o;
}

//

/**
 * Accessor options
 * @typedef {Object} AccessorOptions
 * @property {Object} [ object=null ] - source object wich properties will get getter/setter defined.
 * @property {Object} [ names=null ] - map that that contains names of fields for wich function defines setter/getter.
 * Function uses values( rawName ) of object( o.names ) properties to check if fields of( o.object ) have setter/getter.
 * Example : if( rawName ) is 'a', function searchs for '_aSet' or 'aSet' and same for getter.
 * @property {Object} [ methods=null ] - object where function searchs for existing setter/getter of property.
 * @property {Array} [ message=null ] - setter/getter prints this message when called.
 * @property {Boolean} [ strict=true ] - makes object field private if no getter defined but object must have own constructor.
 * @property {Boolean} [ enumerable=true ] - sets property descriptor enumerable option.
 * @property {Boolean} [ preservingValue=true ] - saves values of existing object properties.
 * @property {Boolean} [ prime=true ]
 * @property {String} [ combining=null ]
 * @property {Boolean} [ readOnly=false ] - if true function doesn't define setter to property.
 * @property {Boolean} [ readOnlyProduct=false ]
 * @property {Boolean} [ configurable=false ]
 * @property {Function} [ get=null ]
 * @property {Function} [ set=null ]
 * @property {Function} [ suite=null ]
 *
 * @namespace Tools.accessor
 **/

/**
 * Defines set/get functions on source object( o.object ) properties if they dont have them.
 * If property specified by( o.names ) doesn't exist on source( o.object ) function creates it.
 * If ( o.object.constructor.prototype ) has property with getter defined function forbids set/get access
 * to object( o.object ) property. Field can be accessed by use of Symbol.for( rawName ) function,
 * where( rawName ) is value of property from( o.names ) object.
 *
 * Can be called in three ways:
 * - First by passing all options in one object( o );
 * - Second by passing ( object ) and ( names ) options;
 * - Third by passing ( object ), ( names ) and ( message ) option as third parameter.
 *
 * @param {Object} o - options {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}.
 *
 * @example
 * let Self = ClassName;
function ClassName( o ) { };
 * _.accessor.declare( Self, { a : 'a' }, 'set/get call' )
 * Self.a = 1; // set/get call
 * Self.a;
 * // returns
 * // set/get call
 * // 1
 *
 * @throws {exception} If( o.object ) is not a Object.
 * @throws {exception} If( o.names ) is not a Object.
 * @throws {exception} If( o.methods ) is not a Object.
 * @throws {exception} If( o.message ) is not a Array.
 * @throws {exception} If( o ) is extented by unknown property.
 * @throws {exception} If( o.strict ) is true and object doesn't have own constructor.
 * @throws {exception} If( o.readOnly ) is true and property has own setter.
 * @function declare
 * @namespace Tools.accessor
 */

function declare_body( o )
{

  _.assertRoutineOptions( declare_body, arguments );

  if( _.arrayLike( o.object ) )
  {
    _.each( o.object, ( object ) =>
    {
      let o2 = _.mapExtend( null, o );
      o2.object = object;
      declare_body( o2 );
    });
    return;
  }

  if( !o.methods )
  o.methods = o.object;

  /* verification */

  _.assert( !_.primitiveIs( o.object ) );
  _.assert( !_.primitiveIs( o.methods ) );
  _.assert( _.objectLikeOrRoutine( o.object ), () => 'Expects object {-object-}, but got ' + _.toStrShort( o.object ) );
  _.assert( _.objectIs( o.names ), () => 'Expects object {-names-}, but got ' + _.toStrShort( o.names ) );

  /* */

  // let names1 = Object.getOwnPropertyNames( o.names );
  // for( let n = 0 ; n < names1.length ; n++ )
  // declare( names1[ n ], o.names[ names1[ n ] ] );

  for( let name in o.names )
  declare( name, o.names[ name ] );

  let names2 = Object.getOwnPropertySymbols( o.names );
  for( let n = 0 ; n < names2.length ; n++ )
  declare( names2[ n ], o.names[ names2[ n ] ],  );

  /* */

  function declare( name, extension )
  {
    let o2 = Object.assign( Object.create( null ), o );

    if( _.mapIs( extension ) )
    {
      _.assertMapHasOnly( extension, _.accessor.AccessorDefaults );
      _.mapExtend( o2, extension );
      _.assert( !!o2.object );
    }
    else if( _.definitionIs( extension ) && extension.subKind === 'constant' )
    {
      _.mapExtend( o2, { get : extension, set : false, put : false } );
    }
    else if( _.routineIs( extension ) && extension.identity && _.longHas( extension.identity, 'functor' ) )
    {
      _.mapExtend( o2, { suite : extension } );
    }
    else _.assert( name === extension, `Unexpected type ${_.strType( extension )}` );

    // _.assert
    // (
    //     _.strIs( o2 ) || _.mapIs( o2 )
    //   , () => `Expects accessor definition, but got ${ _.strType( o2 ) } for accessor ${ name }`
    // );

    // if( _.strIs( o2 ) )
    // {
    //   _.assert( o2 === name, 'map for forbid should have same key and value' );
    //   o2 = _.mapExtend( null, o );
    // }
    // else
    // {
    //   _.assertMapHasOnly( o2, _.accessor.AccessorDefaults );
    //   o2 = _.mapExtend( null, o, o2 );
    //   _.assert( !!o2.object );
    // }

    o2.name = name;
    delete o2.names;

    _.accessor._declareAct( o2 );
  }

}

var defaults = declare_body.defaults = _.mapExtend( null, _declareAct.defaults );
defaults.names = null;
delete defaults.name;

let declare = _.routineUnite( _declare_head, declare_body );

//

/**
 * @summary Declares forbid accessor.
 * @description
 * Forbid accessor throws an Error when user tries to get value of the property.
 * @param {Object} o - options {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}.
 *
 * @example
 * let Self = ClassName;
function ClassName( o ) { };
 * _.accessor.forbid( Self, { a : 'a' } )
 * Self.a; // throw an Error
 *
 * @function forbid
 * @namespace Tools.accessor
 */

function forbid_body( o )
{

  _.assertRoutineOptions( forbid_body, arguments );

  if( !o.methods )
  o.methods = Object.create( null );

  if( _.arrayLike( o.object ) )
  {
    debugger;
    _.each( o.object, ( object ) =>
    {
      let o2 = _.mapExtend( null, o );
      o2.object = object;
      forbid_body( o2 );
    });
    debugger;
    return;
  }

  if( _.objectIs( o.names ) )
  o.names = _.mapExtend( null, o.names );

  if( o.prime === null )
  o.prime = _.prototypeIsStandard( o.object );

  /* verification */

  _.assert( _.objectLikeOrRoutine( o.object ), () => 'Expects object {-o.object-} but got ' + _.toStrShort( o.object ) );
  _.assert( _.objectIs( o.names ) || _.arrayIs( o.names ), () => 'Expects object {-o.names-} as argument but got ' + _.toStrShort( o.names ) );

  /* message */

  let _constructor = o.object.constructor || null;
  _.assert( _.routineIs( _constructor ) || _constructor === null );
  _.assert( _constructor === null || _.strIs( _constructor.name ) || _.strIs( _constructor._name ), 'object should have name' );
  if( !o.protoName )
  o.protoName = ( _constructor ? ( _constructor.name || _constructor._name || '' ) : '' ) + '.';
  if( !o.message )
  o.message = 'is deprecated';
  else
  o.message = _.arrayIs( o.message ) ? o.message.join( ' : ' ) : o.message;

  /* property */

  if( _.objectIs( o.names ) )
  {

    for( let n in o.names )
    {
      let name = o.names[ n ];
      let o2 = _.mapExtend( null, o );
      o2.fieldName = name;
      _.assert( n === name, () => 'Key and value should be the same, but ' + _.strQuote( n ) + ' and ' + _.strQuote( name ) + ' are not' );
      if( !_.accessor._forbidDeclare( o2 ) )
      delete o.names[ name ];
    }

  }
  else
  {

    let namesArray = o.names;
    o.names = Object.create( null );
    for( let n = 0 ; n < namesArray.length ; n++ )
    {
      let name = namesArray[ n ];
      let o2 = _.mapExtend( null, o );
      o2.fieldName = name;
      if( _.accessor._forbidDeclare( o2 ) )
      o.names[ name ] = name;
    }

  }

  _.assert( !o.strict );
  _.assert( !o.prime );

  o.strict = 0;
  o.prime = 0;

  return _.accessor.declare.body( _.mapOnly( o, _.accessor.declare.body.defaults ) );
}

// var defaults = forbid_body.defaults = Object.create( declare.body.defaults );

var defaults = forbid_body.defaults =
{

  ... _.mapExtend( null, declare.body.defaults ),

  preservingValue : 0,
  enumerable : 0,
  combining : 'rewrite',
  message : null,

  prime : 0,
  strict : 0,

}

// delete defaults.strict;
// delete defaults.prime;

let forbid = _.routineUnite( _declare_head, forbid_body );

//

function _forbidDeclare()
{
  let o = _.routineOptions( _forbidDeclare, arguments );
  let setterName = '_' + o.fieldName + 'Set';
  let getterName = '_' + o.fieldName + 'Get';
  let messageLine = o.protoName + o.fieldName + ' : ' + o.message;

  _.assert( _.strIs( o.protoName ) );
  _.assert( _.objectIs( o.methods ) );

  /* */

  let propertyDescriptor = _.propertyDescriptorActiveGet( o.object, o.fieldName );
  if( propertyDescriptor.descriptor )
  {
    _.assert( _.strIs( o.combining ), 'forbid : if accessor overided expect ( o.combining ) is', _.accessor.Combining.join() );

    if( _.routineIs( propertyDescriptor.descriptor.get ) && propertyDescriptor.descriptor.get.name === 'forbidden' )
    {
      return false;
    }

  }

  /* check fields */

  if( o.strict )
  if( propertyDescriptor.object === o.object )
  {
    if( _.accessor.ownForbid( o.object, o.fieldName ) )
    {
      return false;
    }
    else
    {
      forbidden();
    }
  }

  /* check fields group */

  if( o.strict && _.prototypeIsStandard( o.object ) )
  if( _.prototypeHasField( o.object, o.fieldName ) )
  {
    forbidden();
  }

  /* */

  if( !Object.isExtensible( o.object ) )
  {
    return false;
  }

  o.methods[ setterName ] = forbidden;
  o.methods[ getterName ] = forbidden;
  forbidden.isForbid = true;

  /* */

  if( o.prime )
  {

    /* !!! not tested */
    let o2 = _.mapExtend( null, o );
    o2.names = o.fieldName;
    o2.object = null;
    delete o2.protoName;
    delete o2.fieldName;

    _.accessor._register
    ({
      proto : o.object,
      name : o.fieldName,
      declaratorName : 'forbid',
      declaratorArgs : [ o2 ],
      combining : o.combining,
    });

  }

  /* */

  return true;

  /* */

  function forbidden()
  {
    debugger;
    throw _.err( messageLine );
  }

}

var defaults = _forbidDeclare.defaults = Object.create( forbid.defaults );

defaults.fieldName = null;
defaults.protoName = null;

//

/**
 * Checks if source object( object ) has own property( name ) and its forbidden.
 * @param {Object} object - source object
 * @param {String} name - name of the property
 *
 * @example
 * let Self = ClassName;
function ClassName( o ) { };
 * _.accessor.forbid( Self, { a : 'a' } );
 * _.accessor.ownForbid( Self, 'a' ) // returns true
 * _.accessor.ownForbid( Self, 'b' ) // returns false
 *
 * @function ownForbid
 * @namespace Tools.accessor
 */

function ownForbid( object, name )
{
  if( !_ObjectHasOwnProperty.call( object, name ) )
  return false;

  let descriptor = Object.getOwnPropertyDescriptor( object, name );
  if( _.routineIs( descriptor.get ) && descriptor.get.isForbid )
  {
    return true;
  }
  else
  {
    return false;
  }

}

// --
// etc
// --

/**
 * @summary Declares read-only accessor( s ).
 * @description Expects two arguments: (object), (names) or single as options map {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}
 *
 * @param {Object} object - target object
 * @param {Object} names - contains names of properties that will get read-only accessor
 *
 * @example
 * var Alpha = function _Alpha(){}
 * _.classDeclare
 * ({
 *   cls : Alpha,
 *   parent : null,
 *   extend : { Composes : { a : null } }
 * });
 * _.accessor.readOnly( Alpha.prototype,{ a : 'a' });
 *
 * @function forbid
 * @namespace Tools.accessor
 */

function readOnly_body( o )
{
  _.assertRoutineOptions( readOnly_body, arguments );
  _.assert( o.readOnly );
  return _.accessor.declare.body( o );
}

var defaults = readOnly_body.defaults = _.mapExtend( null, declare.body.defaults );
defaults.readOnly = true;

let readOnly = _.routineUnite( _declare_head, readOnly_body );

//

/**
 * @summary Supplements target object( dst ) with accessors from source object( src ).
 *
 * @description
 * Both objects should have accessorts map defined.
 * Ignores accessor that is already declared on destination object( dst ).
 *
 * @param {Object} src - source object
 * @param {Object} dst - destination object
 *
 * @throws {Exception} If number of arguments is not supported.
 * @throws {Exception} If combining method of source accessor is unknown.
 * @throws {Exception} If accessor.declaratorArgs is not a Array.
 * @throws {Exception} If one of object doesn't have _Accessors map
 * @function supplement
 *
 * @namespace Tools.accessor
 */

function supplement( dst, src )
{

  _.workpiece.fieldsGroupFor( dst, '_Accessors' );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _ObjectHasOwnProperty.call( dst, '_Accessors' ), 'supplement : dst should has _Accessors map' );
  _.assert( _ObjectHasOwnProperty.call( src, '_Accessors' ), 'supplement : src should has _Accessors map' );

  /* */

  for( let a in src._Accessors )
  {

    let accessor = src._Accessors[ a ];

    if( _.objectIs( accessor ) )
    supplement( a, accessor );
    else for( let i = 0 ; i < accessor.length ; i++ )
    supplement( a, accessor[ i ] );

  }

  /* */

  function supplement( name, accessor )
  {

    _.assert( _.arrayIs( accessor.declaratorArgs ) );
    _.assert( !accessor.combining || accessor.combining === 'rewrite' || accessor.combining === 'supplement' || accessor.combining === 'append', 'not implemented' );

    if( _.objectIs( dst._Accessors[ name ] ) )
    return;

    if( accessor.declaratorName !== 'accessor' )
    {
      _.assert( _.routineIs( dst[ accessor.declaratorName ] ), 'dst does not have accessor maker', accessor.declaratorName );
      dst[ accessor.declaratorName ].apply( dst, accessor.declaratorArgs );
    }
    else
    {
      _.assert( accessor.declaratorArgs.length === 1 );
      let optionsForAccessor = _.mapExtend( null, accessor.declaratorArgs[ 0 ] );
      optionsForAccessor.object = dst;
      if( !optionsForAccessor.methods )
      optionsForAccessor.methods = dst;
      _.accessor.declare( optionsForAccessor );
    }

  }

}

// --
// etc
// --

/**
 * Returns true if source object( proto ) has accessor with name( name ).
 * @param {Object} proto - target object
 * @param {String} name - name of accessor
 * @function has
 * @namespace Tools.accessor
 */

function has( proto, name )
{
  let accessors = proto._Accessors;
  if( !accessors )
  return false;
  return !!accessors[ name ];
}

//

function suiteMakerFrom_functor( fop )
{

  if( arguments.length === 2 )
  fop = { getterFunctor : arguments[ 0 ], setterFunctor : arguments[ 1 ] }

  _.routineOptions( suiteMakerFrom_functor, fop );

  let defaults;
  if( fop.getterFunctor )
  defaults = _.mapExtend( null, fop.getterFunctor.defaults );
  else
  defaults = _.mapExtend( null, fop.setterFunctor.defaults );

  if( fop.getterFunctor && _.entityIdentical )
  _.assert( _.entityIdentical( defaults, _.mapExtend( null, fop.getterFunctor.defaults ) ) );
  if( fop.setterFunctor && _.entityIdentical )
  _.assert( _.entityIdentical( defaults, _.mapExtend( null, fop.setterFunctor.defaults ) ) );

  let _head = fop.getterFunctor.head || fop.setterFunctor.head;
  if( _head )
  accessorMaker.head = head;

  accessorMaker.defaults = defaults;

  return accessorMaker;

  /* */

  function head( routine, args )
  {
    let o2 = _head( routine, args );
    return o2;
  }

  /* */

  function accessorMaker( o )
  {
    let r = Object.create( null );

    if( _head )
    o = head( accessorMaker, arguments );
    else
    o = _.routineOptions( accessorMaker, arguments );

    if( fop.setterFunctor )
    if( fop.setterFunctor.body )
    r.set = fop.setterFunctor.body( o );
    else
    r.set = fop.setterFunctor( o );

    if( fop.getterFunctor )
    if( fop.getterFunctor.body )
    r.get = fop.getterFunctor.body( o );
    else
    r.get = fop.getterFunctor( o );

    return r;
  }

}

suiteMakerFrom_functor.defaults =
{
  getterFunctor : null,
  setterFunctor : null,
}

// --
// meta
// --

function _DefinesGenerate( dst, src, kind )
{
  if( dst === null )
  dst = Object.create( null );

  _.assert( arguments.length === 3 );

  for( let s in src )
  {
    dst[ s ] = _DefineGenerate( src[ s ], kind );
  }

  return dst;
}

//

function _DefineGenerate( original, kind )
{
  _.assert( _.routineIs( original ) );

  let r =
  {
    [ original.name ] : function()
    {
      let definition = _.define[ kind ]({ ini : arguments, routine : original });
      _.assert( _.definitionIs( definition ) );
      return definition;
    }
  }

  let routine = r[ original.name ];

  _.routineExtend( routine, original );
  _.assert( arguments.length === 2 );

  routine.originalFunctor = original;

  _.assert( _.routineIs( _.define[ kind ] ) );

  return routine;
}

// --
// relations
// --

let DefaultAccessorsMap = Object.create( null );
DefaultAccessorsMap.Accessors = declare;
DefaultAccessorsMap.Forbids = forbid;
DefaultAccessorsMap.AccessorsForbid = forbid;
DefaultAccessorsMap.AccessorsReadOnly = readOnly;

let Forbids =
{
  _ArrayDescriptor : '_ArrayDescriptor',
  ArrayDescriptor : 'ArrayDescriptor',
  _ArrayDescriptors : '_ArrayDescriptors',
  ArrayDescriptors : 'ArrayDescriptors',
  arrays : 'arrays',
  arrayOf : 'arrayOf',
}

//

let AccessorExtension =
{

  // getter / setter generator

  _propertyGetterSetterNames,
  _optionsNormalize,
  _methodsMake,
  _methodsUnfunct,
  _methodUnfunct,
  _methodsNames,
  _methodsRetrieve,
  _methodsValidate,
  _methodCopyGet,

  copyIterationMake,

  // declare

  _register,
  _declare_head,
  _declareAct,
  declare,

  // forbid

  forbid,
  _forbidDeclare,
  ownForbid,

  supplement,

  // etc

  readOnly,
  has,

  // meta

  suiteMakerFrom_functor,
  _DefinesGenerate,
  _DefineGenerate,

  // fields

  AccessorDefaults,
  AccessorPreferences,
  Combining,
  AccessorType,
  DefaultAccessorsMap,

}

//

let ToolsExtension =
{
}

// --
// extend
// --

_.accessor = _.accessor || Object.create( null );
_.mapSupplement( _, ToolsExtension );
_.mapExtend( _.accessor, AccessorExtension );

_.accessor.forbid( _, Forbids );
_.accessor.forbid( _.accessor, Forbids );

_.accessor.getter = _.accessor.getter || Object.create( null );
_.accessor.taker = _.accessor.taker || Object.create( null );
_.accessor.setter = _.accessor.setter || Object.create( null );
_.accessor.putter = _.accessor.putter || Object.create( null );
_.accessor.suite = _.accessor.suite || Object.create( null );
_.accessor.define = _.accessor.define || Object.create( null );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
