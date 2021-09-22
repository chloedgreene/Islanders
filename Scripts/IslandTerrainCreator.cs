using Godot;
using System;

public class IslandTerrainCreator : Spatial
{
    const int SIZE = 320;

    public override void _Ready()
    {
        generate_island();
    }

    public void generate_island(){
        GD.Print("Starting Making Island");
        GD.Randomize();

        //Setup Tools needed
        SurfaceTool  surface_tool   = new SurfaceTool();
        MeshDataTool mesh_data_tool = new MeshDataTool();
        OpenSimplexNoise noise      = new OpenSimplexNoise();
        //Setup Plane Mesh
        PlaneMesh plane_mesh = new PlaneMesh();
        plane_mesh.Size = new Vector2(SIZE,SIZE);
        plane_mesh.SubdivideDepth = SIZE / 2;
        plane_mesh.SubdivideWidth = SIZE / 2;
        //Setup Noise
        Random rng = new Random();
        noise.Seed = rng.Next(0,2147483640);
        noise.Octaves = 5;
        noise.Period = 120;
        //TODO find out what this code does again
        surface_tool.CreateFrom(plane_mesh,0);
        ArrayMesh array_mesh = surface_tool.Commit();
        mesh_data_tool.CreateFromSurface(array_mesh,0);
        
        //Do some CRAZY math to make the hilly terrain a island
        Vector2 radius = (new Vector2(1.0f - SIZE - 1,1.0f - SIZE - 1)) / 2;
        float ratio = (SIZE-1 / SIZE-1);

        //Make Terrain
        for(int i = 0;i <= mesh_data_tool.GetVertexCount() - 1; i++){
            Vector3 vertux = mesh_data_tool.GetVertex(i);
            float value = noise.GetNoise3d(vertux.x,vertux.y,vertux.z);

            float dist = new Vector2(0,0).DistanceTo(new Vector2(vertux.x, vertux.z));
			float ofs = dist / radius.y;
			
            value += ofs;

            vertux.y = (value * 50);

            vertux.y -= 23;

            

            mesh_data_tool.SetVertex(i,vertux);

        }

        for(int s = 0; s <= array_mesh.GetSurfaceCount();s++){
            array_mesh.SurfaceRemove(s);
        }
        mesh_data_tool.CommitToSurface(array_mesh);
        surface_tool.Begin(Mesh.PrimitiveType.Triangles);
        surface_tool.CreateFrom(array_mesh,0);
        surface_tool.GenerateNormals();

        SpatialMaterial material = new SpatialMaterial();
        MeshInstance meshInstance = new MeshInstance();
        meshInstance.Mesh = surface_tool.Commit();
        meshInstance.CreateTrimeshCollision();
        material.AlbedoColor = new Color(0x640000);
        meshInstance.MaterialOverride = material;

        this.AddChild(meshInstance);

        //this.GetNode("WaterLevel").

    }
}
