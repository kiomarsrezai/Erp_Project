using System;
using System.Collections.Generic;
    using AutoMapper;

namespace NewsWebsite.ViewModels {


    public class MyMapper {


        // single Entity
        public static TVM MapTo<TEntity, TVM>(TEntity entity,Action<IMappingExpression<TEntity, TVM>>? mappingExpression = null){
            var mappingConfig = new MapperConfiguration(cfg => {
                cfg.CreateMap<TEntity, TVM>();
                mappingExpression?.Invoke(cfg.CreateMap<TEntity, TVM>());
            });
            var mapper = mappingConfig.CreateMapper();
            return mapper.Map<TVM>(entity);
        }  
    
        public static TVM MapTo<TEntity, TVM>(TEntity entity, MapperConfiguration mappingConfig){
            var mapper = mappingConfig.CreateMapper();
            return mapper.Map<TVM>(entity);
        }
    
    
        // List Entity

        public static List<TVM> MapTo<TEntity, TVM>(List<TEntity> entities,Action<IMappingExpression<TEntity, TVM>>? mappingExpression = null){
            var mappingConfig = new MapperConfiguration(cfg =>{
                cfg.CreateMap<TEntity, TVM>();
                mappingExpression?.Invoke(cfg.CreateMap<TEntity, TVM>());
            });

            return MapTo<TEntity, TVM>(entities,mappingConfig);
        }


        public static List<TVM> MapTo<TEntity, TVM>(List<TEntity> entities, MapperConfiguration mappingConfig){
            var mapper = mappingConfig.CreateMapper();
            var mapItems = new List<TVM>();
            foreach (var entity in entities){
                mapItems.Add(mapper.Map<TVM>(entity));
            }

            return mapItems;
        }
    }
}