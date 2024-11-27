//
//  Constants.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

enum NetworkConstants {
    static var baseUrl: String {
    #if DEBUG
        //return "http://localhost:8080"
        //return "http://192.168.1.26:8080"
        return "https://kirala-dev.onrender.com"
        //return   "http://13.61.3.36:8080"
        //return "http://172.16.34.221:8080"
        //return "http://192.168.1.111:8080"
        //return "http://172.16.35.37:8080"
        //return "http://192.168.214.230:8080"
    #else
        return "https://example.com/api"
    #endif
    }
    
    enum Endpoints {
        enum Auth {
            static let loginWithGoogle = "oauth2/authorize/google"
            static let login = "/auth/login"
            static let register = "/auth/register"
            static let logout = "/auth/logout"
            static let forgotPassword = "/auth/send-reset-password-token"
            static let resetPassword = "/auth/reset-password"
            static let resendVerificationEmail = "/auth/send-email-verification-token"
        }
        
        enum Category {
            static let getCategories = "/categories"
            static let getSubcategories = "/subcategories/category/"
            static let getBrands = "/brands"
            static let getCities = "/cities"
            static let getCampaigns = "/campaigns"
            static let getCategoryListWithSubcategories = "/categories/subcategories"
        }
        
        enum Product {
            static let createProduct = "/products"
            static let getProductsByUser = "/products/user"
            static let getProductById = "/products/"
            static let updateProduct = "/products"
            static let deleteProduct = "/products/"
            static let getProducts = "/products"
            static let getSearchedProducts = "/products/search"
            static let getProductDetail = "/products/details"
            static let rentProduct = "/orders"
        }
        
        enum Favorite {
            static let getFavorites = "/favorites"
            static let toggleFavorite = "/favorites"
        }
        
    }
    
    enum Constraints {
        static let paginationSize = 10
        static let infinityScrollLateLimitSecond = 1.0
        static let infinityScrollPercentage = 0.9
    }
    
    
    static let mockImageUrls: [URL] = [
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1570/prod/QC/20240925/15/8d480e57-dd9f-33be-869d-d6a99e2adade/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240925/15/f0b8c711-ff2f-3710-acf9-5cd771967845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240516/11/e93aaa49-1c9e-34bd-a82e-abf40880b39e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1315/product/media/images/prod/QC/20240516/11/0e13fb17-e88c-30b3-adee-ba925ee8c782/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty733/product/media/images/20230215/16/281514998/111694438/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty732/product/media/images/20230215/16/281514998/111694438/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1024/product/media/images/prod/PIM/20231025/06/0fd69241-dbf3-4b43-a692-899775a80ef6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty540/product/media/images/20220926/18/180084094/538071101/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1447/product/media/images/prod/QC/20240729/09/e17bdc05-7683-3e80-b81f-e87fc8a6b876/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/7b24976e-e76d-3194-9da6-017f47909a14/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty535/product/media/images/20220920/12/177395184/573896464/6/6_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty536/product/media/images/20220920/12/177395184/573896464/7/7_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240916/09/c684fa8d-8545-3cb5-aa15-ba8eb8c255cc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/prod/QC/20240916/09/cfa89e65-f54e-3871-87ad-8175196033e7/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/3ff94a9e-df9a-3175-90b7-c3dc1cb78e73/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/258683e4-28c1-3826-9670-46188df621c0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1585/prod/QC/20241014/13/f6c01efa-d6f5-3806-a7b7-c5638551bc4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/f4baf3f8-9ab3-3798-90c7-d6c9d9504237/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240926/10/6624c92d-ffd6-33ae-830f-01007f1a2325/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240926/10/441ca172-2ae9-38b6-9f92-47a70df95766/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1513/product/media/images/prod/QC/20240830/01/0cc96eca-259a-347a-8f71-28ba9c563f6a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1603/prod/QC/20241121/10/56a84499-32b3-374a-865d-0c79a8c7e020/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty277/product/media/images/20211221/16/14559465/342205646/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty276/product/media/images/20211221/16/14559465/342205646/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/2b70e5e3-c0bb-39ae-924a-bd41569041de/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/44f32513-8cf8-3ba7-9dcd-48d39915cc7b/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241029/16/81b34bdc-5353-3f44-8f22-58817aad33dc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/b68ecfb8-1df8-305f-a1eb-8219cd36986c/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/134152bb-b725-3fe0-acb9-54ee599b3c13/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1257/product/media/images/prod/SPM/PIM/20240415/11/847e381c-2fe2-3645-aa25-dacc54ec4d37/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240515/14/b2460abb-4d95-3960-bd36-df0fcbec4121/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty813/product/media/images/20230405/12/318761422/22005446/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240917/02/8b394267-1b35-3e46-8ca2-1bb802686975/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/9643298e-65e1-32dc-b252-a730c3aaa198/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1553/prod/QC/20240917/13/16920366-48df-3d84-8a74-628a76643845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1416/product/media/images/prod/QC/20240712/12/da2a8b02-962a-3a46-9764-ef99dfaa7349/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1417/product/media/images/prod/QC/20240712/12/98ed2619-0671-31aa-b4f9-5a5f53a4c89a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1029/product/media/images/prod/SPM/PIM/20231102/16/2545f337-d7c0-309c-8d70-11fad0b3d1c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1031/product/media/images/prod/SPM/PIM/20231102/16/84ac8bc8-59f3-3a2b-97f6-109a13a71145/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1006/product/media/images/prod/SPM/PIM/20230929/15/13eecdaa-ed18-3610-90b6-726f3c7d27a0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty987/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053589/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty989/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053593/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1342/product/media/images/prod/QC/20240531/04/70d72990-dc6c-3da9-90ec-0c02ce8e7552/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1341/product/media/images/prod/QC/20240531/04/226e1f09-bdc0-3059-885f-c8d8e6734202/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty150/product/media/images/20210729/16/113766387/10134133/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty152/product/media/images/20210729/16/113766387/10134133/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/product/media/images/ty1548/prod/QC/20240916/20/20766a5b-f625-36ce-86cf-65e48d966a93/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/20/e7f77216-257f-3b9a-8946-31a84035aa3e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240925/04/0e95be23-9ea5-3f78-9f6c-a4ba368209b6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty510/product/media/images/20220819/12/162769283/535963447/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty512/product/media/images/20220819/12/162769283/535963447/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1082/product/media/images/prod/SPM/PIM/20231207/11/01d1b716-06aa-304a-960b-b104c4837ec5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1496/product/media/images/prod/QC/20240822/12/c935c07b-5745-3fd1-ba1c-9608d7219ff1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1390/product/media/images/prod/QC/20240629/14/a4926d7d-a05b-3238-870b-459e6693f5b9/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1172/product/media/images/prod/SPM/PIM/20240215/11/cb4f2827-8e37-3c8e-ae04-cdfea923c3f0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1017/product/media/images/prod/SPM/PIM/20231018/21/6d32725b-9b40-3e36-876c-6694d3817ee5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/14/52b0a590-20b5-32da-bb17-8c151fae6e63/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240924/12/faff19b1-a229-3936-8370-f565e257fd66/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1579/prod/QC/20241007/01/e162159b-844a-3def-a864-6d68a98fef69/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1219/product/media/images/prod/SPM/PIM/20240321/15/c6f8a41f-8c22-38c1-aa5c-ffa7cf7f4de3/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1084/product/media/images/prod/SPM/PIM/20231209/05/f15a067f-f8d3-3209-9ec8-8078eaaf5d49/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1548/prod/QC/20240916/09/4afd2df2-c42e-3fd5-a34e-de5f1eff2b1e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty966/product/media/images/20230715/19/394144502/10741120/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1542/prod/QC/20240913/19/4f5e45b4-6437-304f-9b6f-05303aa66ecb/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1552/prod/QC/20240917/13/3a4b4274-a4ce-3301-8826-0991136632c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/60a64c78-366a-3900-9a74-df0f5ff11a7a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1552/product/media/images/ty1553/prod/QC/20240917/13/a641c839-cf9a-3f85-bb71-e048d3336b4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1553/product/media/images/ty1551/prod/QC/20240917/13/9598b0ba-cb8b-31bb-bf42-cd98413dac88/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241025/16/86a26f8c-f8c9-3238-8295-79c1d95a7244/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty955/product/media/images/20230622/16/388194671/232491004/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty972/product/media/images/20230729/3/397884604/983629085/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1589/prod/QC/20241018/16/288f4814-ec7f-3302-9b5e-45b3e9279369/1_org_zoom.jpg".imageUrl,
        
        
        
        
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1607/prod/QC/20241125/10/c892993a-f60f-373d-a8e0-151ebea3e202/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1586/prod/QC/20241016/13/b8cd799d-1300-3bae-b069-3fff8ae0e749/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241016/13/7d82845d-2ce1-3cad-9d5c-d5af5de19ccb/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1585/prod/QC/20241016/13/321339e7-05f7-3191-bf06-e4318832aa4a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1529/product/media/images/prod/QC/20240906/22/a139200f-dba6-3fc3-9225-1f1820fb4acd/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1529/product/media/images/prod/QC/20240906/22/82218b6b-e9e5-3f6d-a04e-0677ab6b4513/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1527/product/media/images/prod/QC/20240906/22/6655da06-03c6-3fcc-ac62-9bf586696260/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1573/prod/QC/20240927/17/6c5086ff-3380-3b94-be90-5c142e290912/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1573/prod/QC/20240927/17/b095df6b-1a5a-356f-99f4-2a111148ad22/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1574/prod/QC/20240927/17/619e9212-2b24-3ea9-8764-7821888b53ac/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1578/prod/QC/20241007/11/941cf510-0c12-3691-92c4-5ee24cba6617/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1579/prod/QC/20241007/11/8c4244f9-4030-396c-80db-5b00d5b42ea9/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1579/prod/QC/20241007/11/ad4f3827-466e-3e84-a10c-3ccba38e33e7/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1578/prod/QC/20241007/11/46d0aef9-b7a7-3c1a-9d9b-556a0db1b52b/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1579/prod/QC/20241007/11/780d4f4e-0d77-3506-9b2e-e9ddcc1ae8ac/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1419/product/media/images/prod/QC/20240715/01/5bfd300a-3dcc-3dab-be15-f35af22e80c9/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1421/product/media/images/prod/QC/20240715/01/4c6b0880-cfd9-353f-a35a-53d48729bc3b/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1420/product/media/images/prod/QC/20240715/01/c05ea5b4-753d-3d59-b308-f12f245645f7/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1419/product/media/images/prod/QC/20240715/01/237eae2a-2875-34a1-94e7-524199f22a59/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1419/product/media/images/prod/QC/20240715/01/19018d15-dc25-329b-93a2-e7a419a0b35f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1481/product/media/images/prod/QC/20240814/23/57f2a202-2e88-38fb-a695-2c08c2f2ba07/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1573/prod/QC/20240927/12/05a0dd66-3b23-31eb-8581-23ac155ddef4/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1574/prod/QC/20240927/12/2c203bd7-4f52-345d-9c83-7eaa7c5048a9/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1574/prod/QC/20240927/12/bd6a163e-481b-385e-bacf-b8d44cfa400e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1573/prod/QC/20240927/12/e962765c-1859-3c4c-9588-37d07e8196bf/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1573/prod/QC/20240927/12/85652c5d-e590-3efe-8416-378264d2d4fb/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty767/product/media/images/20230307/12/298391885/879773370/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty766/product/media/images/20230307/12/298391885/879773370/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty765/product/media/images/20230307/12/298391885/879773370/5/5_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1321/product/media/images/prod/QC/20240517/00/ac2b0dfb-c1ae-38a9-a410-709259056ea2/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1322/product/media/images/prod/QC/20240517/00/73d4f982-285a-33af-bbd7-69217e467280/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1320/product/media/images/prod/QC/20240517/00/b68bf21d-3e07-3c3a-b3a9-f24d5c45800a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1322/product/media/images/prod/QC/20240517/00/46d9561f-2143-3a78-a3ba-81238b2c564b/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1321/product/media/images/prod/QC/20240517/00/231bee63-c7cb-36c2-86fd-2676f54b6ff1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1320/product/media/images/prod/QC/20240517/00/0e07c161-8a3a-3623-96af-74addcc66fd8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1347/product/media/images/prod/QC/20240604/09/86106d8c-4dbc-3ae2-b37d-4d04a5d5e21c/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1349/product/media/images/prod/QC/20240604/09/cd88988f-7657-3c7e-89f8-7a6bbc5a3927/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty883/product/media/images/20230515/16/349591505/938560782/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty883/product/media/images/20230515/16/349591505/938560782/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty882/product/media/images/20230515/16/349591505/938560782/4/4_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1581/prod/QC/20241012/16/be6992d4-eb7c-3d20-a212-18a76f9755a4/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1582/prod/QC/20241012/16/7a2e6d50-0af0-3e1f-b54f-1611258822c4/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1582/prod/QC/20241012/16/67e64a39-4d82-38f3-86a6-a64bf5279d95/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1576/prod/QC/20241001/18/5aef819f-765f-38cb-b636-ec849f92f519/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1600/prod/QC/20241110/21/7eeceb74-196b-32b3-ac13-ce7ef7fa67af/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty331/product/media/images/20220212/19/49258486/122026518/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1541/product/media/images/ty1540/prod/QC/20240913/10/2d400a97-951f-37f1-b439-6ee2193f8cc8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1539/product/media/images/ty1540/prod/QC/20240913/10/acc8879f-afc9-33c6-a765-55463f8ead7f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1540/product/media/images/ty1541/prod/QC/20240913/10/6841fe5e-6a51-37fe-8a5b-11ae9ab89a46/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1315/product/media/images/prod/QC/20240516/14/af729df6-9429-3108-a05a-25eb0f835d99/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1315/product/media/images/prod/QC/20240516/14/6c71e3c4-721a-3d13-bc40-279a5bb6c523/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1570/prod/QC/20240924/21/269575a6-a09f-3ccd-a4d2-6085a2c32daf/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240924/21/bec15ae0-a9e2-3c24-9cba-d9f5dd039672/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty883/product/media/images/20230513/16/348256807/937030480/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty882/product/media/images/20230513/16/348256807/937030480/4/4_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1570/prod/QC/20240924/21/931a6e44-3acb-340e-bf52-c5278bc16672/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1590/prod/QC/20241021/17/6f3010f4-9eb0-322e-b973-1a5144e1b175/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1321/product/media/images/prod/SPM/PIM/20240406/21/7d9c4122-66a4-32c2-a2df-67ed8ec53463/1_org_zoom.jpg".imageUrl,
        
        
        
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1570/prod/QC/20240925/15/8d480e57-dd9f-33be-869d-d6a99e2adade/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240925/15/f0b8c711-ff2f-3710-acf9-5cd771967845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240516/11/e93aaa49-1c9e-34bd-a82e-abf40880b39e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1315/product/media/images/prod/QC/20240516/11/0e13fb17-e88c-30b3-adee-ba925ee8c782/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty733/product/media/images/20230215/16/281514998/111694438/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty732/product/media/images/20230215/16/281514998/111694438/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1024/product/media/images/prod/PIM/20231025/06/0fd69241-dbf3-4b43-a692-899775a80ef6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty540/product/media/images/20220926/18/180084094/538071101/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1447/product/media/images/prod/QC/20240729/09/e17bdc05-7683-3e80-b81f-e87fc8a6b876/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/7b24976e-e76d-3194-9da6-017f47909a14/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty535/product/media/images/20220920/12/177395184/573896464/6/6_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty536/product/media/images/20220920/12/177395184/573896464/7/7_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240916/09/c684fa8d-8545-3cb5-aa15-ba8eb8c255cc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/prod/QC/20240916/09/cfa89e65-f54e-3871-87ad-8175196033e7/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/3ff94a9e-df9a-3175-90b7-c3dc1cb78e73/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/258683e4-28c1-3826-9670-46188df621c0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1585/prod/QC/20241014/13/f6c01efa-d6f5-3806-a7b7-c5638551bc4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/f4baf3f8-9ab3-3798-90c7-d6c9d9504237/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240926/10/6624c92d-ffd6-33ae-830f-01007f1a2325/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240926/10/441ca172-2ae9-38b6-9f92-47a70df95766/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1513/product/media/images/prod/QC/20240830/01/0cc96eca-259a-347a-8f71-28ba9c563f6a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1603/prod/QC/20241121/10/56a84499-32b3-374a-865d-0c79a8c7e020/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty277/product/media/images/20211221/16/14559465/342205646/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty276/product/media/images/20211221/16/14559465/342205646/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/2b70e5e3-c0bb-39ae-924a-bd41569041de/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/44f32513-8cf8-3ba7-9dcd-48d39915cc7b/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241029/16/81b34bdc-5353-3f44-8f22-58817aad33dc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/b68ecfb8-1df8-305f-a1eb-8219cd36986c/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/134152bb-b725-3fe0-acb9-54ee599b3c13/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1257/product/media/images/prod/SPM/PIM/20240415/11/847e381c-2fe2-3645-aa25-dacc54ec4d37/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240515/14/b2460abb-4d95-3960-bd36-df0fcbec4121/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty813/product/media/images/20230405/12/318761422/22005446/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240917/02/8b394267-1b35-3e46-8ca2-1bb802686975/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/9643298e-65e1-32dc-b252-a730c3aaa198/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1553/prod/QC/20240917/13/16920366-48df-3d84-8a74-628a76643845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1416/product/media/images/prod/QC/20240712/12/da2a8b02-962a-3a46-9764-ef99dfaa7349/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1417/product/media/images/prod/QC/20240712/12/98ed2619-0671-31aa-b4f9-5a5f53a4c89a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1029/product/media/images/prod/SPM/PIM/20231102/16/2545f337-d7c0-309c-8d70-11fad0b3d1c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1031/product/media/images/prod/SPM/PIM/20231102/16/84ac8bc8-59f3-3a2b-97f6-109a13a71145/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1006/product/media/images/prod/SPM/PIM/20230929/15/13eecdaa-ed18-3610-90b6-726f3c7d27a0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty987/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053589/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty989/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053593/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1342/product/media/images/prod/QC/20240531/04/70d72990-dc6c-3da9-90ec-0c02ce8e7552/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1341/product/media/images/prod/QC/20240531/04/226e1f09-bdc0-3059-885f-c8d8e6734202/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty150/product/media/images/20210729/16/113766387/10134133/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty152/product/media/images/20210729/16/113766387/10134133/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/product/media/images/ty1548/prod/QC/20240916/20/20766a5b-f625-36ce-86cf-65e48d966a93/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/20/e7f77216-257f-3b9a-8946-31a84035aa3e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240925/04/0e95be23-9ea5-3f78-9f6c-a4ba368209b6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty510/product/media/images/20220819/12/162769283/535963447/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty512/product/media/images/20220819/12/162769283/535963447/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1082/product/media/images/prod/SPM/PIM/20231207/11/01d1b716-06aa-304a-960b-b104c4837ec5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1496/product/media/images/prod/QC/20240822/12/c935c07b-5745-3fd1-ba1c-9608d7219ff1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1390/product/media/images/prod/QC/20240629/14/a4926d7d-a05b-3238-870b-459e6693f5b9/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1172/product/media/images/prod/SPM/PIM/20240215/11/cb4f2827-8e37-3c8e-ae04-cdfea923c3f0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1017/product/media/images/prod/SPM/PIM/20231018/21/6d32725b-9b40-3e36-876c-6694d3817ee5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/14/52b0a590-20b5-32da-bb17-8c151fae6e63/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240924/12/faff19b1-a229-3936-8370-f565e257fd66/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1579/prod/QC/20241007/01/e162159b-844a-3def-a864-6d68a98fef69/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1219/product/media/images/prod/SPM/PIM/20240321/15/c6f8a41f-8c22-38c1-aa5c-ffa7cf7f4de3/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1084/product/media/images/prod/SPM/PIM/20231209/05/f15a067f-f8d3-3209-9ec8-8078eaaf5d49/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1548/prod/QC/20240916/09/4afd2df2-c42e-3fd5-a34e-de5f1eff2b1e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty966/product/media/images/20230715/19/394144502/10741120/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1542/prod/QC/20240913/19/4f5e45b4-6437-304f-9b6f-05303aa66ecb/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1552/prod/QC/20240917/13/3a4b4274-a4ce-3301-8826-0991136632c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/60a64c78-366a-3900-9a74-df0f5ff11a7a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1552/product/media/images/ty1553/prod/QC/20240917/13/a641c839-cf9a-3f85-bb71-e048d3336b4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1553/product/media/images/ty1551/prod/QC/20240917/13/9598b0ba-cb8b-31bb-bf42-cd98413dac88/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241025/16/86a26f8c-f8c9-3238-8295-79c1d95a7244/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty955/product/media/images/20230622/16/388194671/232491004/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty972/product/media/images/20230729/3/397884604/983629085/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1589/prod/QC/20241018/16/288f4814-ec7f-3302-9b5e-45b3e9279369/1_org_zoom.jpg".imageUrl,
    ]
    
    
    static let mockCampaignUrls: [URL] = [
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/7946f9ea-8cff-43e6-bb9c-8c35afdcedebtr_3206619.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1606/tr-event-banner/088c34ee-a153-423d-a07c-650f7e9847e6tr_3207482.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/1d0af2bd-dbf2-4f90-9bf6-a8c4465ac71btr_3205959.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/a1d225b2-1024-4abd-9ddb-8326b6dfb35dtr_3206496.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/5b206aa5-5bd7-420a-80f0-4a2a83c67f93tr_3206705.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/03c69356-06f7-46f0-a3a2-141d7c26637btr_3207171.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/f41a8017-de56-4aea-9d3d-f38576fe3aeetr_3207025.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/42d55bd6-9185-40f2-948c-6adb83b6ef8ctr_3207133.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/cdfd180b-cca6-4c33-a800-e187b0c6aaa0tr_3205296.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1606/tr-event-banner/3a1c9a3e-5ef8-4f4c-a263-22db0c50429ctr_3204795.jpeg".imageUrl,
        
        "https://up.roketfy.com/media/trendyol-kampanya-nasil-yapilir.webp".imageUrl,
        "https://up.roketfy.com/media/trendyol-kampanya-nasil-yapilir.webp".imageUrl,
        "https://up.roketfy.com/media/trendyol-kampanya-nasil-yapilir.webp".imageUrl,
        
        "https://www.ininal.com/uploads/2022/09/23/web1920x1080ininal-x-trendyol-kampanyasi_1663936311.png".imageUrl,
        "https://pazarlamaturkiye.com/wp-content/uploads/2020/09/1600335251_Trendyol_Reklam_Kampanyas__3-800x464.jpeg".imageUrl,
        "https://media.licdn.com/dms/image/v2/D4D12AQEFGDXMsNjTDQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1668172426828?e=1738195200&v=beta&t=QFQp0BBT30jqqh0_eHKyV7ASlTdn36rBIPT-QVLOqyg".imageUrl,
        "https://media.licdn.com/dms/image/v2/D4D12AQFxSGp9bdy42Q/article-inline_image-shrink_1500_2232/article-inline_image-shrink_1500_2232/0/1668172490515?e=1738195200&v=beta&t=BcHeu_KKYCfR_Yk_qYq0IFgeqZhSNBMMC_wpdKUqdpU".imageUrl,
        "https://media.licdn.com/dms/image/v2/D4D12AQGIOm6jk_Pr8Q/article-inline_image-shrink_1500_2232/article-inline_image-shrink_1500_2232/0/1668173138377?e=1738195200&v=beta&t=G9x2TWqTiaWq_gzOiCjqSLG-RiqGDtxevjsgRTDdf44".imageUrl,
        "https://static.daktilo.com/sites/1168/uploads/2024/09/26/trendyolda-kampanya-cilginligi-basladi.webp".imageUrl,
        "https://www.worldcard.com.tr/getmedia/ecfdbc86-c1e9-4c7a-ab84-6053d76860cd/30008200005_1.webp?ext=.webp".imageUrl,
        "https://www.hedefhalk.com/images/haberler/2021/04/trendyol-bahari-kampanya-ile-karsiliyor-1619508640.jpg".imageUrl,
        "https://image.hurimg.com/i/hurriyet/75/0x0/61aa15d74e3fe0042c173b0e.jpg".imageUrl,
        "https://www.paraf.com.tr/tr/kampanyalar/e-ticaret/trendyolda-pesin-fiyatina-3-taksit-firsati123/_jcr_content/root/responsivegrid/container_109478952_/teaser.coreimg.100.3840.jpeg/1675932603460/trendyol-paraf-kampanyadetaybanner-guide-text.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/11b97465-1004-4326-b442-f2969c171093tr_3206781.jpeg".imageUrl,
    ]
    
}
