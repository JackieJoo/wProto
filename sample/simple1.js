( function _Consequence_s_(){

'use strict';

if( typeof module !== 'undefined' )
{
  require( 'wProto' );
}

//

var _ = wTools;
var Parent = function Alpha(){}
Parent.prototype.init = function(){}
Parent.prototype.methodOfAlpha = function(){ console.log( 'method of alpha' ); }

var Self = function Betta()
{
  if( !( this instanceof Self ) )
  return new( _.routineJoin( Self, Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );
}

//

var init = function init()
{
  var self = this;
  Parent.prototype.init.call( this );

  _.mapExtendFiltering( _.filter.own(),self,Composes );

}

//

var finit = function finit()
{
  var self = this;

  Object.freeze( self );

}

//

var methodOfBetta = function methodOfBetta()
{
  var self = this;

  console.log( 'method of betta' );

}

//

var staticFunction = function staticFunction()
{

  if( this === Self )
  console.log( 'static function called as static' );
  else
  console.log( 'static function called as method' );

}

//

var Composes =
{
  a : 1,
  b : 2,
}

//

var Proto =
{

  init: init,
  finit: finit,

  methodOfBetta: methodOfBetta,

  constructor: Self,
  Composes: Composes,

}

var Static =
{

  staticFunction : staticFunction,

}

_.protoMake
({
  constructor : Self,
  parent : Parent,
  extend : Proto,
  static : Static,
});

_global_.Alpha = Parent;
_global_.Betta = Self;

//

var betta = new Betta();

betta.methodOfAlpha();
betta.methodOfBetta();

betta.staticFunction();
Betta.staticFunction();

console.log( 'betta.a : ' + betta.a );
console.log( 'betta.b : ' + betta.b );

})();
