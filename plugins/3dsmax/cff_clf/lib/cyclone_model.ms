/*

*/

filein "lib/max.ms"

struct cyclonModelHeader
(
  origin = (point3 0 0 0),
  scale = (point3 0 0 0),
  textureCount = 0,
  materialCount = 0,
  meshCount = 0,
  frameCount = 0,
  lodCount = 0,
  occlusionRadius = 0
)

struct cycloneTextureName
(
  length = 0,
  name = ""   
)

struct cycloneMaterialUnknown
(
  Unknown1 = 0,
  Unknown2 = 0,
  Unknown3 = 0,
  Unknown4 = 0,
  Unknown5 = 0
)

struct cycloneMaterial
(
  Unknown1 = 0,
  Unknown2 = 0,
  Unknown3 = 0,
  Unknown4 = 0,
  Unknown5 = 0,
  Unknown6 = 0,
  Unknown7 = 0,
  Unknown8 = 0,
  Unknown9 = #() 
)

struct cycloneModelLodVertex
(
  origin = (point3 0 0 0) 
)

struct cycloneModelLodHeader
(
  origin = (point3 0 0 0), 
  uvDelim = 0,
  occlusionRadius = 0,
  textureIndex = 0,
  vertexCount = 0,
  faceCount = 0,
  unknown = 0,
  frameCount = 0,
  name = 0
)

struct cycloneModelLodMeshVertex
(
  coordinates = (point3 0 0 0),
  uv = (point3 0 0 0),
  color = (point3 0 0 0)
)

struct cycloneModelLodMeshFace
(
  indexes = (point3 0 0 0)  
)

struct cycloneModelLodAnimationFrame
(
  position = (point3 0 0 0),
  rotation = (point3 0 0 0),
  time = 0
)

struct cycloneModelLodMesh
(
  header = cycloneModelLodHeader(),
  vertexes = #(),
  faces = #(),
  animationFrames = #() 
)

struct cycloneModelLod
(
  meshes = #()
)

struct cycloneModel
(
  name = "",
  header = cyclonModelHeader(),
  textureList = #(),
  materials = #(),
  modelLods = #(),
  fn addLod objs = 
  (
    lod = cycloneModelLod()
    for obj in objs do
    (
      lodMesh = cycloneModelLodMesh()
	  for i = 1 to obj.numverts do
	  (
	    vertex = cycloneModelLodMeshVertex()
		vertex.coordinates = getVert obj i
		append lodMesh.vertexes vertex
	  )
	  
	  for i = 1 to obj.numfaces do
	  (	  
	    face = cycloneModelLodMeshFace()
		indexes = getFace obj i
	    append lodMesh.faces (indexes - 1)
	  )
	  	  
	  for i = 1 to obj.position.controller.keys.count do
	  (
	    frame = cycloneModelLodAnimationFrame()	
		posKey = getKey obj.position.controller (i)
		rotKey = getKey obj.rotation.controller (i)
        frame.position = posKey.value
		frame.rotation = rotKey.value
		frame.time = i - 1
		append lodMesh.animationFrames frame
	  )
	  
      append lod.meshes lodMesh    
    )
    append modelLods lod
  )
)