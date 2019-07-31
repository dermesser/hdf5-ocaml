open Bigarray

module Ext : sig
  type t
end

module Mem : sig
  type t
end

module Bigstring : sig
  (** Represents a string outside the heap *)
  type t

  external of_string : string -> t = "hdf5_caml_struct_bigstring_of_string"
  external to_string : t -> string = "hdf5_caml_struct_bigstring_to_string"

  (** The given [Array1] must be [NULL] terminated *)
  val of_array1 : (char, int8_unsigned_elt, c_layout) Array1.t -> t
  val to_array1 : t -> (char, int8_unsigned_elt, c_layout) Array1.t
end

module Array_float32 : sig
  type t = (float, float32_elt, c_layout) Array1.t
end

module Array_float64 : sig
  type t = (float, float64_elt, c_layout) Array1.t
end

module Array_sint8 : sig
  type t = (int, int8_signed_elt, c_layout) Array1.t
end

module Array_uint8 : sig
  type t = (int, int8_unsigned_elt, c_layout) Array1.t
end

module Array_sint16 : sig
  type t = (int, int16_signed_elt, c_layout) Array1.t
end

module Array_uint16 : sig
  type t = (int, int16_unsigned_elt, c_layout) Array1.t
end

module Array_int32 : sig
  type t = (int32, int32_elt, c_layout) Array1.t
end

module Array_int64 : sig
  type t = (int64, int64_elt, c_layout) Array1.t
end

module Array_int : sig
  type t = (int, int_elt, c_layout) Array1.t
end

module Array_nativeint : sig
  type t = (nativeint, nativeint_elt, c_layout) Array1.t
end

module Array_char : sig
  type t = (char, int8_unsigned_elt, c_layout) Array1.t

  external of_string : string -> t = "hdf5_caml_struct_array_char_of_string"
  external to_string : t -> string = "hdf5_caml_struct_array_char_to_string"
end

module Ptr : sig
  type t

  val unsafe_next : t -> int -> unit
  val unsafe_prev : t -> int -> unit
  val unsafe_move : t -> int -> int -> unit
  val next : t -> int -> unit
  val prev : t -> int -> unit
  val move : t -> int -> int -> unit

  val get_float64   : t -> int -> float
  val set_float64   : t -> int -> float -> unit
  val get_int       : t -> int -> int
  val set_int       : t -> int -> int -> unit
  val get_int64     : t -> int -> int64
  val set_int64     : t -> int -> int64 -> unit
  val get_string    : t -> int -> int -> string
  val set_string    : t -> int -> int -> string -> unit

  (** A more efficient version of [get_string] which avoids [memcpy]. *)
  val get_bigstring : t -> int -> int -> Bigstring.t

  (** A more efficient version of [set_string] which avoids [memcpy]. *)
  val set_bigstring : t -> int -> int -> Bigstring.t -> unit

  val get_array_float32   : t -> int -> int -> Array_float32.t
  val set_array_float32   : t -> int -> int -> Array_float32.t   -> unit
  val get_array_float64   : t -> int -> int -> Array_float64.t
  val set_array_float64   : t -> int -> int -> Array_float64.t   -> unit
  val get_array_sint8     : t -> int -> int -> Array_sint8.t
  val set_array_sint8     : t -> int -> int -> Array_sint8.t     -> unit
  val get_array_uint8     : t -> int -> int -> Array_uint8.t
  val set_array_uint8     : t -> int -> int -> Array_uint8.t     -> unit
  val get_array_sint16    : t -> int -> int -> Array_sint16.t
  val set_array_sint16    : t -> int -> int -> Array_sint16.t    -> unit
  val get_array_uint16    : t -> int -> int -> Array_uint16.t
  val set_array_uint16    : t -> int -> int -> Array_uint16.t    -> unit
  val get_array_int32     : t -> int -> int -> Array_int32.t
  val set_array_int32     : t -> int -> int -> Array_int32.t     -> unit
  val get_array_int64     : t -> int -> int -> Array_int64.t
  val set_array_int64     : t -> int -> int -> Array_int64.t     -> unit
  val get_array_int       : t -> int -> int -> Array_int.t
  val set_array_int       : t -> int -> int -> Array_int.t       -> unit
  val get_array_nativeint : t -> int -> int -> Array_nativeint.t
  val set_array_nativeint : t -> int -> int -> Array_nativeint.t -> unit
  val get_array_char      : t -> int -> int -> Array_char.t
  val set_array_char      : t -> int -> int -> Array_char.t      -> unit

  val seek_int             : t -> int -> int -> int               -> unit
  val seek_int64           : t -> int -> int -> int64             -> unit
  val seek_float64         : t -> int -> int -> float             -> unit
  val seek_string          : t -> int -> int -> int -> string     -> unit
  val seek_bigstring       : t -> int -> int -> Bigstring.t       -> unit
  val seek_array_float32   : t -> int -> int -> Array_float32.t   -> unit
  val seek_array_float64   : t -> int -> int -> Array_float64.t   -> unit
  val seek_array_sint8     : t -> int -> int -> Array_sint8.t     -> unit
  val seek_array_uint8     : t -> int -> int -> Array_uint8.t     -> unit
  val seek_array_sint16    : t -> int -> int -> Array_sint16.t    -> unit
  val seek_array_uint16    : t -> int -> int -> Array_uint16.t    -> unit
  val seek_array_int32     : t -> int -> int -> Array_int32.t     -> unit
  val seek_array_int64     : t -> int -> int -> Array_int64.t     -> unit
  val seek_array_int       : t -> int -> int -> Array_int.t       -> unit
  val seek_array_nativeint : t -> int -> int -> Array_nativeint.t -> unit
  val seek_array_char      : t -> int -> int -> Array_char.t      -> unit
end

module type S = sig
  val fields : Field.t list
end

module Make(S : S) : Struct_intf.S_no_ppx

(** Must be called before each call to [Marshal.to_*] to preserve sharing. *)
external reset_serialize : unit -> unit = "hdf5_caml_struct_reset_serialize"

(** Must be called before each call to [Marshal.from_*] to preserve sharing. *)
external reset_deserialize : unit -> unit = "hdf5_caml_struct_reset_deserialize"
