#include "AssetLoader.hpp"
#include "MemoryManager.hpp"
#include "OGEX.hpp"
#include <iostream>
#include <string>

using namespace My;
using namespace std;

namespace My {
    IMemoryManager* g_pMemoryManager = new MemoryManager();
    AssetLoader*   g_pAssetLoader   = new AssetLoader();
}

template<typename Key, typename T>
static ostream& operator<<(ostream& out, unordered_map<Key, shared_ptr<T>> map)
{
    for (const auto& p : map)
    {
        if (auto ptr = p.second)
            out << *ptr << endl;
    }

    return out;
}

int main(int , char** )
{
    g_pMemoryManager->Initialize();
    g_pAssetLoader->Initialize();

    string ogex_text = g_pAssetLoader->SyncOpenAndReadTextFileToString("Scene/splash.ogex");

    auto* ogex_parser = new OgexParser ();
    int count = 0;
    shared_ptr<Scene> pScene = ogex_parser->Parse(ogex_text);
    delete ogex_parser;

    g_pAssetLoader->Finalize();
    g_pMemoryManager->Finalize();

    delete g_pAssetLoader;
    delete g_pMemoryManager;

    return 0;
}

