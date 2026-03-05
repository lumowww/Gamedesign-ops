using UnityEngine;
using UnityEditor;
using System.IO;

namespace GAMEDEVGD.EditorTools
{
    public class PlaceholderArtGenerator : EditorWindow
    {
        private const string ArtPath = "Assets/Art/Placeholders";
        private const string PrefabPath = "Assets/Art/Placeholders/Prefabs";
        private const string MatPath = "Assets/Art/Placeholders/Materials";

        [MenuItem("GameDev Squad/Generate ART Placeholders")]
        public static void ShowWindow()
        {
            GetWindow<PlaceholderArtGenerator>("Placeholder Gen");
        }

        private void OnGUI()
        {
            GUILayout.Label("AiW Sprint 1: ART Generation", EditorStyles.boldLabel);

            if (GUILayout.Button("Generate All Placeholders"))
            {
                CreateFolders();
                GenerateMaterials();
                GeneratePrefabs();
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
                Debug.Log("[ART] All Placeholder assets generated successfully!");
            }
        }

        private void CreateFolders()
        {
            if (!AssetDatabase.IsValidFolder("Assets/Art")) AssetDatabase.CreateFolder("Assets", "Art");
            if (!AssetDatabase.IsValidFolder(ArtPath)) AssetDatabase.CreateFolder("Assets/Art", "Placeholders");
            if (!AssetDatabase.IsValidFolder(PrefabPath)) AssetDatabase.CreateFolder(ArtPath, "Prefabs");
            if (!AssetDatabase.IsValidFolder(MatPath)) AssetDatabase.CreateFolder(ArtPath, "Materials");
        }

        private void GenerateMaterials()
        {
            // Tower Materials
            CreateMaterial("Mat_Incinerator", new Color(1f, 0.4f, 0f)); // Orange-Red
            CreateMaterial("Mat_Cryo", new Color(0f, 0.6f, 1f)); // Blue-Cyan
            
            // Creep Materials
            CreateMaterial("Mat_CreepFast", new Color(0.2f, 0.8f, 0.2f)); // Green
            CreateMaterial("Mat_CreepTank", new Color(0.6f, 0.1f, 0.8f)); // Purple
            
            // Grid Materials
            CreateMaterial("Mat_TileBuild", new Color(0.8f, 0.8f, 0.8f)); // Light Gray
            CreateMaterial("Mat_TilePath", new Color(0.3f, 0.3f, 0.3f)); // Dark Gray
            CreateMaterial("Mat_TileStart", new Color(0.8f, 0.2f, 0.2f)); // Red
            CreateMaterial("Mat_TileBase", new Color(0.2f, 0.2f, 0.8f)); // Blue
        }

        private void CreateMaterial(string name, Color color)
        {
            string path = $"{MatPath}/{name}.mat";
            if (AssetDatabase.LoadAssetAtPath<Material>(path) == null)
            {
                Material mat = new Material(Shader.Find("Universal Render Pipeline/Simple Lit"));
                mat.color = color;
                AssetDatabase.CreateAsset(mat, path);
            }
        }

        private void GeneratePrefabs()
        {
            // Tiles
            CreatePrefabFromPrimitive("Tile_Build", PrimitiveType.Quad, "Mat_TileBuild", new Vector3(1, 1, 1));
            CreatePrefabFromPrimitive("Tile_Path", PrimitiveType.Quad, "Mat_TilePath", new Vector3(1, 1, 1));
            CreatePrefabFromPrimitive("Tile_Start", PrimitiveType.Quad, "Mat_TileStart", new Vector3(1, 1, 1));
            CreatePrefabFromPrimitive("Tile_Base", PrimitiveType.Quad, "Mat_TileBase", new Vector3(1, 1, 1));

            // Creeps
            CreatePrefabFromPrimitive("Creep_Fast", PrimitiveType.Capsule, "Mat_CreepFast", new Vector3(0.5f, 0.5f, 0.5f));
            CreatePrefabFromPrimitive("Creep_Tank", PrimitiveType.Cube, "Mat_CreepTank", new Vector3(0.8f, 0.5f, 0.8f));

            // Towers
            GenerateTowerBase("Tower_Incinerator", "Mat_Incinerator");
            GenerateTowerBase("Tower_Cryo", "Mat_Cryo");
        }

        private void CreatePrefabFromPrimitive(string name, PrimitiveType type, string matName, Vector3 scale)
        {
            GameObject obj = GameObject.CreatePrimitive(type);
            obj.name = name;
            obj.transform.localScale = scale;
            
            // Assign material
            Material mat = AssetDatabase.LoadAssetAtPath<Material>($"{MatPath}/{matName}.mat");
            if (mat != null) obj.GetComponent<MeshRenderer>().sharedMaterial = mat;

            // Save Prefab
            string path = $"{PrefabPath}/{name}.prefab";
            PrefabUtility.SaveAsPrefabAsset(obj, path);
            DestroyImmediate(obj);
        }

        private void GenerateTowerBase(string prefix, string matName)
        {
            Material mat = AssetDatabase.LoadAssetAtPath<Material>($"{MatPath}/{matName}.mat");

            for (int i = 1; i <= 3; i++)
            {
                GameObject root = new GameObject($"{prefix}_Lv{i}");
                
                // Base
                GameObject tBase = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
                tBase.transform.SetParent(root.transform);
                tBase.transform.localPosition = new Vector3(0, 0.25f, 0);
                tBase.transform.localScale = new Vector3(0.8f, 0.25f, 0.8f);
                if (mat != null) tBase.GetComponent<MeshRenderer>().sharedMaterial = mat;

                // Level indicator (size increases with level)
                GameObject indicator = GameObject.CreatePrimitive(PrimitiveType.Cube);
                indicator.transform.SetParent(root.transform);
                indicator.transform.localPosition = new Vector3(0, 0.75f, 0);
                
                if (prefix.Contains("Incinerator"))
                {
                    // Wide, horizontal for Incinerator
                    indicator.transform.localScale = new Vector3(0.4f + (i * 0.2f), 0.3f, 0.3f);
                }
                else
                {
                    // Tall, vertical for Cryo
                    indicator.transform.localScale = new Vector3(0.3f, 0.4f + (i * 0.2f), 0.3f);
                }
                if (mat != null) indicator.GetComponent<MeshRenderer>().sharedMaterial = mat;

                string path = $"{PrefabPath}/{root.name}.prefab";
                PrefabUtility.SaveAsPrefabAsset(root, path);
                DestroyImmediate(root);
            }
        }
    }
}
