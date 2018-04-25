( function _ProtoLike_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  require( './Proto.s' );

}

/*

!!!

- implement custom instnaceof for structures

*/

var _ = _global_.wTools;
var _hasOwnProperty = Object.hasOwnProperty;
var _assert = _.assert;
var _nameFielded = _.nameFielded;

_.assert( !_.construction )
if( _.construction )
return;

//

var Parent = null;
var Self = function wLike( o )
{
}

Self.nameShort = 'Like';

// --
// helper
// --

function like()
{
  var helper = new Self();
  var proto = Object.create( null );
  var location;

  Object.defineProperty( proto, 'copy',
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : function copy( o )
    {
      // debugger;
      _.assert( arguments.length === 1 );
      _.mapExtend( this,o );
      return this;
    }
  });

  Object.defineProperty( proto, 'constructor',
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : function Construction( o )
    {
      _.assert( arguments.length === 0 || arguments.length === 1,'construction expects one or none argument' );

      if( !( this instanceof proto.constructor ) )
      if( o instanceof proto.constructor )
      return o;
      else
      return new( _.routineJoin( proto.constructor, proto.constructor, arguments ) );

      _.assertMapHasOnly( this,proto,'Prototype of the object ' + ( location ? 'defined at\n' + location + '\n' : '' ) + 'does not have requested fields.' );

      _.mapComplement( this,proto );
      Object.preventExtensions( this );

      if( o )
      _.mapExtend( this,o );

      return this;
    }
  });

  var allClasses = [ proto ];
  for( var a = 0 ; a < arguments.length ; a++ )
  {
    var arg = arguments[ a ];
    _.assert( arg[ symbolForAllClasses ] );
    if( arg[ symbolForAllClasses ] )
    _.arrayAppendArrayOnce( allClasses,arg[ symbolForAllClasses ] );
  }

  proto.constructor.prototype = proto;

  Object.defineProperty( proto, symbolForParents,
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : _.arraySlice( arguments ),
  });

  Object.defineProperty( proto, symbolForAllClasses,
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : allClasses,
  });

  Object.defineProperty( proto, symbolForClass,
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : proto,
  });

  /* */

  helper.proto = proto;
  helper.usingPrototype = false;

  Object.freeze( helper );

  if( arguments.length > 0 )
  _.mapExtend.apply( _,Array.prototype.concat.apply( [ proto ],arguments ) );

  return helper;
}

//

function name( src )
{
  _.assert( arguments.length === 1 );
  return this;
}

//

function also( src )
{
  _.assert( arguments.length === 1 );
  _.mapExtend( this.proto,src );
  return this;
}

//

function but( src )
{
  _.assert( arguments.length === 1 );
  _.mapDelete( this.proto,src );
  return this;
}

//

function _endGet()
{
  return this.proto;
}

//

function isLike( instance,parent )
{
  _.assert( arguments.length === 2 );
  if( !instance[ symbolForAllClasses ] )
  return false;
  return instance[ symbolForAllClasses ].indexOf( parent ) !== -1;
}

//

function is( instance )
{
  _.assert( arguments.length === 1 );
  if( !instance )
  return false;
  if( !instance.constructor )
  return false;
  if( instance.constructor.name === 'Construction' )
  return true;
}

// --
// var
// --

var symbolForParents = Symbol.for( 'parents' );
var symbolForClass = Symbol.for( 'class' );
var symbolForAllClasses = Symbol.for( 'allClasses' );

// --
// prototype
// --

var Proto =
{
  is : is,
  isLike : isLike,
}

_.assert( !_.construction );
_.construction = Object.create( null );
_.mapExtend( _.construction, Proto );

// --
// prototype
// --

var Proto =
{
  like : like,
}

_.mapExtend( _, Proto );

// --
// prototype
// --

var Proto =
{
  name : name,
  also : also,
  but : but,
  _endGet : _endGet,
}

_.classMake
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.accessorReadOnly
({
  object : Self.prototype,
  names : { end : { readOnlyProduct : 0 } },
});

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_._UsingWtoolsPrivately_ )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
