import "base:intrinsics"

silly :: proc($T:typeid) -> T where instrinsics.type_is_numeric(T) {
	return T(10 + 9)
}
