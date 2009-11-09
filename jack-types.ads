generic
  type Sample_Type is digits <>;

package Jack.Types is
  pragma Pure (Jack.Types);

  subtype Sample_Type_t is Sample_Type;

end Jack.Types;
